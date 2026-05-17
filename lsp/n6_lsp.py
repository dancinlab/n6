#!/usr/bin/env python3
# n6-lsp — canonical LSP server for the .n6 knowledge-atlas grammar (v1).
# Stdio JSON-RPC, zero deps (Python 3.8+). Spec-grounded diagnostics +
# hover, from spec/n6.md. Conservative: unrecognised body forms are
# hints (sev 2), never hard errors.
#
#   n6-lsp                # speak LSP on stdin/stdout
#   n6-lsp --check FILE   # one-shot lint (exit 1 on any error)
import json
import re
import sys

TYPES = {
    "P": "Primitive — irreducible foundational value",
    "C": "Constant — computed from primitives",
    "L": "Law — qualitative principle / invariant",
    "F": "Formula — explicit functional form",
    "R": "Relation — equality / structural identity",
    "S": "Symmetry — topological / group-theoretic property",
    "X": "Crossing — bridge between domains",
    "?": "Unknown — open hypothesis awaiting breakthrough",
    "E": "Experiment — empirical measurement record",
}
EDGES = {
    "<-": "depends_on", "->": "derives", "=>": "application",
    "==": "equivalent", "~>": "converges_to", "|>": "verified_by",
    "!!": "breakthrough",
}
# @<type> <id>[ = <expr>] :: <domain> [<grade>]
HDR = re.compile(r"^@[A-Z?]\s+.+?::\s*\S+\s*\[[^\]\n]*\]\s*$")
KV = re.compile(r"^\S+\s*=")


def diag(ln, c0, c1, msg, sev=1):
    return {"range": {"start": {"line": ln, "character": c0},
                      "end": {"line": ln, "character": c1}},
            "severity": sev, "source": "n6-lsp", "message": msg}


def validate(text):
    out = []
    if text.startswith("﻿"):
        out.append(diag(0, 0, 1, "byte-canonical: UTF-8 with no BOM"))
    if "\r" in text:
        out.append(diag(0, 0, 1, "byte-canonical: LF line endings only"))
    for i, raw in enumerate(text.split("\n")):
        s = raw.rstrip("\r")
        t = s.strip()
        if t == "" or t.startswith("#"):
            continue
        indent = len(s) - len(s.lstrip(" "))
        if s.startswith("@"):
            if indent:
                out.append(diag(i, 0, len(s),
                           "entry header must start at column 0"))
                continue
            ty = s[1] if len(s) > 1 else ""
            if ty not in TYPES:
                out.append(diag(i, 1, 2,
                    "unknown entry type @%s (alphabet: @%s)"
                    % (ty, " @".join(TYPES))))
            if not HDR.match(s):
                out.append(diag(i, 0, len(s),
                    "malformed header — expected "
                    "`@<type> <id>[ = <expr>] :: <domain> [<grade>]`"))
        else:
            if indent != 2:
                out.append(diag(i, 0, len(s),
                    "continuation indented exactly 2 spaces"))
                continue
            tok = t.split(" ", 1)[0]
            if not (tok in EDGES or t.startswith('"') or KV.match(t)):
                out.append(diag(i, 2, len(s),
                    "unrecognised continuation — expected an edge (%s) "
                    "or \"prose\"" % " ".join(EDGES), sev=2))
    return out


def hover(line):
    s = line.strip()
    if s.startswith("@") and len(s) > 1 and s[1] in TYPES:
        return "**@%s** — %s" % (s[1], TYPES[s[1]])
    for e, mng in EDGES.items():
        if s.startswith(e):
            return "**%s** — %s edge" % (e, mng)
    return None


def _read():
    h = {}
    while True:
        ln = sys.stdin.buffer.readline()
        if not ln:
            return None
        ln = ln.decode("ascii", "replace").strip()
        if not ln:
            break
        if ":" in ln:
            k, v = ln.split(":", 1)
            h[k.strip().lower()] = v.strip()
    n = int(h.get("content-length", "0"))
    try:
        return json.loads(sys.stdin.buffer.read(n).decode("utf-8", "replace"))
    except Exception:
        return {}


def _send(o):
    b = json.dumps(o).encode("utf-8")
    sys.stdout.buffer.write(b"Content-Length: %d\r\n\r\n" % len(b) + b)
    sys.stdout.buffer.flush()


def _publish(uri, text):
    try:
        d = validate(text)
    except Exception as e:
        d = [diag(0, 0, 1, "n6-lsp internal: %s" % e, 2)]
    _send({"jsonrpc": "2.0", "method": "textDocument/publishDiagnostics",
           "params": {"uri": uri, "diagnostics": d}})


def serve():
    docs = {}
    while True:
        m = _read()
        if m is None:
            break
        meth = m.get("method")
        if meth == "initialize":
            _send({"jsonrpc": "2.0", "id": m.get("id"), "result": {
                "capabilities": {"textDocumentSync": 1,
                                 "hoverProvider": True},
                "serverInfo": {"name": "n6-lsp"}}})
        elif meth == "shutdown":
            _send({"jsonrpc": "2.0", "id": m.get("id"), "result": None})
        elif meth == "exit":
            break
        elif meth == "textDocument/didOpen":
            d = m["params"]["textDocument"]
            docs[d["uri"]] = d.get("text", "")
            _publish(d["uri"], docs[d["uri"]])
        elif meth == "textDocument/didChange":
            p = m["params"]
            ch = p.get("contentChanges") or [{}]
            docs[p["textDocument"]["uri"]] = ch[-1].get("text", "")
            _publish(p["textDocument"]["uri"],
                     docs[p["textDocument"]["uri"]])
        elif meth == "textDocument/didClose":
            u = m["params"]["textDocument"]["uri"]
            docs.pop(u, None)
            _send({"jsonrpc": "2.0",
                   "method": "textDocument/publishDiagnostics",
                   "params": {"uri": u, "diagnostics": []}})
        elif meth == "textDocument/hover":
            p = m["params"]
            txt = docs.get(p["textDocument"]["uri"], "")
            ln = p["position"]["line"]
            lines = txt.split("\n")
            hv = hover(lines[ln]) if 0 <= ln < len(lines) else None
            _send({"jsonrpc": "2.0", "id": m.get("id"),
                   "result": ({"contents": {"kind": "markdown",
                                            "value": hv}} if hv else None)})
        elif m.get("id") is not None:
            _send({"jsonrpc": "2.0", "id": m["id"], "result": None})


def main():
    if len(sys.argv) > 2 and sys.argv[1] == "--check":
        text = open(sys.argv[2], encoding="utf-8", errors="replace").read()
        ds = validate(text)
        for d in ds:
            print("%s:%d: %s%s" % (
                sys.argv[2], d["range"]["start"]["line"] + 1,
                "" if d["severity"] == 1 else "[hint] ", d["message"]))
        sys.exit(1 if any(d["severity"] == 1 for d in ds) else 0)
    serve()


if __name__ == "__main__":
    main()

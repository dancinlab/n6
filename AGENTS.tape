#!/usr/bin/env tape
# ══════════════════════════════════════════════════════════════════════
# .tape v1.2 — grammar primer (cold-read by any LLM / agent / human)
# ══════════════════════════════════════════════════════════════════════
# Form: each entry is `@<type> <id> := "<subject>" :: <kind> [<grades>]`
#       optionally followed by body lines (2-space indent) — key=value,
#       edges (<- -> => …), or quoted prose.
#
# ENTRY TYPES (17):
#   Runtime (10): @S session  @U user  @A assistant  @T tool-call  @R result
#                 @H hook  @D decision  @K cost  @P provider  @? anomaly
#   Foundation:   @I identity-claim
#   Declarative:  @X external-citation  @F forbidden-pattern  @N note
#                 @C config  @L layout  @V spec-version
#
# EDGES (12, on body lines, 2-space indent):
#   Causal:     <- caused-by   -> triggers   == continues
#               ~> supersedes  !! aborts     |> verified-by
#   Effect:     => produces (followed by quoted natural-language)
#   Structural: <: specializes  :> generalizes  ?> soft-depends
#               !> conflicts-with  @> projects-to (e.g. @> AGENTS.md)
#
# GRADE TAGS (in [...] on entry header):
#   Delivery:   ok · err · denied · cancelled · partial · superseded
#   Governance: required · recommended · optional · draft · active · deprecated
#   Scoped:     allow:<x> · deny:<x>
#   Time/index: T<n> (turn)  N<n> (wall-sec)  d=<YYYY-MM-DD>
#
# PAYLOAD SYNTAX (body lines):
#   key = "value"           single-line string
#   key = [a, b, c]         array literal
#   key <<~EOF              heredoc (multi-line; ends with EOF on own line)
#     multi-line text
#   EOF
#   "see [@x1] §3"          inline citation by entry id
#   `cmd or path`           backtick code-span (inline only)
#
# Full spec: ~/core/tape/spec/tape.md (or github.com/dancinlab/tape)
# ══════════════════════════════════════════════════════════════════════
#
# AGENTS.tape for `dancinlab/n6` — NEXUS-6 Knowledge Atlas

# ─── §1 Spec version ──────────────────────────────────────────────────

@V := "tape" :: spec [active]
  version = "1.2"
  uses = [@I, @L, @D, @F, @X, @H, "<:", "@>", "[required]", "[@id]"]
  primer = "see top-of-file 39-line comment block"

# ─── §2 Identity claims (what n6 IS) ──────────────────────────────────

@I id001 := "n6" :: identity-claim [d=2026-05-14 active]
  kind = "NEXUS-6 Knowledge Atlas — semantic atom layer"
  tagline = "typed verified atoms · grade ladder · provenance edges"
  axis = "semantic-atlas serialization (not byte canon, not runtime trace)"
  grammar = "append-only · line-oriented · grep-friendly · type-graded"
  grade-ladder = "0–10 numeric grade with `*` verified · `!` breakthrough · `?` hypothesis"
  type-alphabet = [@P, @R, @F, @C, @X, @S, @L, @D, @?]
  parent = "dancinlab ecosystem · cites echoes/LATTICE_POLICY.md as authority"

@I id002 := "n6.sibling-format-role" :: identity-claim [d=2026-05-14 active]
  <: id001
  role = "the SEMANTIC layer of the 4-sibling dancinlab format family"
  siblings = ["n6 (semantic atoms)", "hxc (byte-canonical wire)", "n12 (12-axis sparse cube)", "tape (agent-execution trace)"]
  cross-axis <<~EOF
    n6  : WHAT is true   — typed verified atoms, grade ladder
    hxc : HOW it ships   — byte-canonical JSON/JSONL on the wire
    n12 : WHERE it sits  — 12-axis sparse cube coordinates
    tape: WHEN it ran    — append-only causal-temporal trace
  EOF
  note = "n6 entries can be cited from .tape bodies (`see [@x_n6]`) and serialized to .hxc on the wire — orthogonal placements, not competing"

# ─── §3 Repo layout ───────────────────────────────────────────────────

@L l1 := "repo-layout" :: structure [active]
  README.md -> "human intro · type alphabet · live preview"
  AGENTS.tape -> "this file · governance + identity (.tape v1.2)"
  CLAUDE.md -> "symlink → AGENTS.tape (Claude Code auto-discovery)"
  LICENSE -> "CC0-1.0"
  TAPE-AUDIT.md -> ".tape v1.1 → v1.2 adoption audit"
  spec/n6.md -> "full n6 grammar spec (v1)"
  algorithms/ -> "atlas_* operators (absorb · bloom · bootstrap · query · scan_opt · mmap · hot_shard …)"
  examples/ -> "sample .n6 corpora"
  syntaxes/ -> "TextMate / shiki grammar bundles"
  docs/ -> "logo · preview-{dark,light}.svg · preview.html"
  scripts/ -> "render_svg.mjs · regenerate live preview"
  tool/ -> "lint / validator helpers"

# ─── §4 Governance rules ──────────────────────────────────────────────

@D g_inherit := "inherits-lattice-policy" :: governance [required]
  rule = "All echoes/LATTICE_POLICY.md rules apply — real-limits-first · lattice-is-tool · verification-anchor-real-limit · no-artificial-ceilings · honesty-obligation-external."
  authority = "[@x_lattice_policy]"
  @> AGENTS.md

@D g1 := "real-limits-first" :: governance [required]
  rule = "The project's ceiling is set by REAL math/physics/engineering limits, NEVER by the n=6 invariant lattice."
  authority = "[@x_lattice_policy]"
  @> AGENTS.md

@D g2 := "lattice-is-tool" :: governance [required]
  rule = "n=6 lattice is a TOOL, not a CONSTRAINT. Use only where it naturally fits."
  <: g1
  @> AGENTS.md

@D g3 := "honesty-obligation-external" :: governance [required deny:write]
  rule = "Claims about external entities (companies · fabs · vendors · standards bodies) must NOT include lattice-fit assertions. Use their OWN invariants."
  authority = "raw#10 C3 · [@x_lattice_policy] §1.3"
  @> AGENTS.md

@D g4 := "commit-conventions" :: governance [recommended]
  rule = "AI-assisted commits include `Co-Authored-By: <model> <noreply@anthropic.com>` trailer; Conventional Commits title."
  @> AGENTS.md

# ─── §5 Forbidden patterns ────────────────────────────────────────────

@F f1 := "lattice-fit-on-external-entity" :: governance [required deny:write]
  pattern = "applying n=6 lattice as derivation rule to TSMC · ASML · IPCC · NASA · SpaceX · CERN · DeepMind · NIST · or any external vendor / standards body"
  exception = "values may coincidentally match — observation OK, derivation NOT OK"
  authority = "[@x_lattice_policy] §1.2/§1.3"

# ─── §6 External citations ────────────────────────────────────────────

@X x_lattice_policy := "echoes/LATTICE_POLICY.md" :: policy [d=2026-05-12 active]
  url = "https://github.com/dancinlab/echoes/blob/main/LATTICE_POLICY.md"
  scope = "cross-project SSOT — real-limits-first · external-entity ban · raw#10 C3"

@X x_tape_spec := "tape v1.2 spec" :: spec [d=2026-05-14 active]
  url = "https://github.com/dancinlab/tape/blob/main/spec/tape.md"
  scope = "this file's grammar reference"

@X x_self_spec := "n6 v1 spec" :: spec [active]
  url = "https://github.com/dancinlab/n6/blob/main/spec/n6.md"
  path = "spec/n6.md"
  scope = "n6 grammar SSOT — entry types · edges · grade markers · validation"

@X x_siblings := "dancinlab sibling formats" :: cross-ref [d=2026-05-14 active]
  n12 = "https://github.com/dancinlab/n12 — 12-axis sparse cube"
  hxc = "https://github.com/dancinlab/hxc — byte-canonical wire (JSON/JSONL canon)"
  tape = "https://github.com/dancinlab/tape — agent-execution trace (this file's format)"
  scope = "4-sibling orthogonal-axis ecosystem · see [@id002] cross-axis table"

# ─── §7 Generator hooks ───────────────────────────────────────────────

@H h1 := "agents-md-replaced" :: generator [active]
  note = "AGENTS.md replaced by this AGENTS.tape (tape v1.2 migration)"
  fallback = "downstream agents.md tooling that doesn't speak .tape can render via `tape_to_agents_md` algorithm"

@H h2 := "claude-md-symlink" :: generator [active]
  rule = "CLAUDE.md → AGENTS.tape symlink so Claude Code auto-discovery picks up the grammar primer first"
  command = `ln -sf AGENTS.tape CLAUDE.md`

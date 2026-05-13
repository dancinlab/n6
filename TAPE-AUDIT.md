# TAPE-AUDIT — n6

`.tape` (agent-execution trace grammar) adoption audit. Read-only; no code changes.

## A. Audit-class ledgers

`n6` is a **spec + reference algorithms** repo — no operational ledgers, no `state/`, no `*.jsonl`, no `*.marker`. The 12 `algorithms/atlas_*.hexa` modules are reference implementations of guarded-append + bloom dedup + health audit, but the actual `.n6` files they manage live upstream in `nexus/`. The repo itself does not run an audit pipeline. No CARGO, no DESIGN ledger here.

## B. Identity surface

Empty `AGENTS.md` (zero bytes), symlinked `CLAUDE.md`. No agent identity carried — n6 ships a knowledge-atlas grammar, not an agent. No `identity.tape` opportunity.

## C. Domain.md files

Root: `README.md` only (plus the symlinked `AGENTS.md` / `CLAUDE.md`). No `<UPPERCASE>(+<UPPERCASE>)*.md` domain convention practiced. Examples (`examples/01_primitives.n6` etc.) are `.n6` data files, not domain docs. Nothing to sibling-pair as `<DOMAIN>.tape`.

## D. Per-run / per-event history

**The high-signal opportunity.** The README + spec describe `.n6` as append-only, type-graded, edge-provenanced — i.e. n6 already speaks the same dialect as `.tape` (typed entries + edges + grade markers). But the repo does NOT record its own **promotion history** (every `atlas.append.<date>.n6` event, every grade upgrade from `[3?]` → `[10*]`, every breakthrough `!!`). That is a textbook Class-T schema-repetitive event stream and an obvious `promotion.tape` candidate: `@T atlas_append :: appended N=12 entries -> [10*]` rows, append-only, KV-cache-stable across resumes.

## E. Promotion candidates

- **n6 atoms (self-host)** — once `promotion.tape` exists, each verified atom (e.g. `@P n = 6 :: foundation [11*]`) could be re-emitted as a `.n6` line in `examples/` (already done) and cross-referenced from a `.tape` event (`@A promoted_to_n6 atom=n=6 :: foundation [11*]`).
- **hxc** — n6 has no JSONL ledgers, so no hxc surface today. If `promotion.tape` lands as Class-T, an hxc encoding of it becomes the natural compression target.
- **n12** — no metric cube cells; out of scope.

## Verdict

**LIGHT** — no cargo ledgers and no identity surface, but a clean `promotion.tape` opportunity tracking atom-promotion events (`@T` rows per atlas append / grade upgrade / breakthrough). Strongest single use-case: dogfooding `.tape` as the historian for `.n6`'s own append-only knowledge growth.

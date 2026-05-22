# n6 documentation index

## Format

- [`spec/n6.md`](../spec/n6.md) — canonical v1 grammar (entry header, type alphabet, grade alphabet, edge operators, streaming invariants, omega closure)

## Examples

- [`examples/01_primitives.n6`](../examples/01_primitives.n6) — `@P` entries with full edge palette
- [`examples/02_relations.n6`](../examples/02_relations.n6) — `@C` / `@F` / `@R` / `@L` mixed
- [`examples/03_crossings.n6`](../examples/03_crossings.n6) — `@X` crossings · `@?` hypotheses · `!!` breakthroughs

## Algorithms

- [`algorithms/`](../algorithms/) — 12 reference hexa-lang modules (guarded append, query, bloom dedup, mmap scan, health audit, etc.)

## Tools

- [`tool/`](../tool/) — planned lint / pilot / consumer-adapter / omega-audit dispatchers (not yet implemented)

## Editor support

- [`syntaxes/n6.tmLanguage.json`](../syntaxes/n6.tmLanguage.json) — TextMate grammar
- [`syntaxes/README.md`](../syntaxes/README.md) — VS Code / Sublime / TextMate install guides

## Design notes

- [`docs/DESIGN.md`](DESIGN.md) — README design + syntax-highlighting path (linguist + TextMate)
- [`docs/omega_closure.md`](omega_closure.md) — abstraction-exhaustion target spec (mirrored from nexus)

## Previews

- [`docs/preview.html`](preview.html) — side-by-side themed renderings (open in any browser)
- [`docs/preview-dark.svg`](preview-dark.svg) / [`preview-light.svg`](preview-light.svg) — README-embeddable theme-aware SVGs

## CI

- [`.github/workflows/lint.yml`](../.github/workflows/lint.yml) — byte-canonical invariants + entry-header well-formedness checks on `examples/*.n6`

## Atlas corpus location (2026-05-22)

- Canonical corpus: `~/core/hexa-lang/n6/atlas.n6` (+ `atlas.append.*.n6` shards)
- Consumers point at it via `HEXA_ATLAS_N6=~/core/hexa-lang/n6` — no symlinks, no per-repo copies
- The `hxc` binary sidecar (`dist/atlas.hxc`) is **retired** as the atlas runtime artifact (hexa-lang PRs [#312](https://github.com/dancinlab/hexa-lang/pull/312), [#314](https://github.com/dancinlab/hexa-lang/pull/314)). The hexa-lang runtime parses `.n6` directly via the merger.
- This repo holds the **grammar spec + reference algorithms only** — it does not vendor the corpus

## Sibling formats

- [`hxc`](https://github.com/dancinlab/hxc) — generic byte-canonical wire format for JSON/JSONL (KV-cache friendly). Note: no longer the atlas runtime sidecar — `.n6` is parsed directly by hexa-lang
- `n12` — 12-axis sparse cube extension (private at `dancinlab/n12`)

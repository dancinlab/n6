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

## Sibling formats

- [`hxc`](https://github.com/dancinlab/hxc) — wire/storage canonical for JSON/JSONL (byte-canonical · KV-cache friendly)
- `n12` — 12-axis sparse cube extension (private at `dancinlab/n12`)

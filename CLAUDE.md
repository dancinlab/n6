<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->

## Atlas corpus SSOT (2026-05-22)

- The canonical `atlas.n6` corpus lives at `~/core/hexa-lang/n6/atlas.n6` (+ `atlas.append.*.n6` shards). Single source of truth.
- Consumers reach it via the `HEXA_ATLAS_N6` env var (e.g. `HEXA_ATLAS_N6=~/core/hexa-lang/n6`). No symlinks, no per-repo copies.
- The `dist/atlas.hxc` binary sidecar is **retired** as the atlas runtime artifact. hexa-lang's `static_atlas()` now parses `.n6` directly via the merger (refs: hexa-lang PRs #312, #314).
- `hxc` remains as a generic byte-canonical wire format for other use cases — it just no longer underpins the atlas runtime.
- This repo (`dancinlab/n6`) ships only the grammar spec, reference algorithms, and didactic `examples/*.n6` — it does NOT vendor the corpus.

# Reference algorithms — `.n6` toolchain

12 hexa-lang modules mirrored from `nexus/n6/`. These are the operational tools that manage `.n6` files in the upstream nexus ecosystem — guarded append, bloom-filter dedup, query, health audit, mmap-backed scan, hot-shard partitioning, and more.

## Provenance

Source: `nexus/n6/atlas_*.hexa`. Written in [hexa-lang](https://github.com/dancinlab/hexa-fusion) — require the hexa-lang interpreter to execute. Reference reading material for porting to other languages.

## Catalog

| Module | Role |
|---|---|
| `atlas_absorb.hexa` | Guarded ingestion — schema check + dedup + `_guarded_append_atlas()` entry point |
| `atlas_bloom.hexa` | Bloom-filter dedup for fast pre-check of `(type, id)` before append |
| `atlas_bootstrap.hexa` | Initial atlas bootstrap from a clean state |
| `atlas_deg_rebuild.hexa` | Degree/edge count rebuild for the `atlas.signals.n6.deg` derived shard |
| `atlas_health.hexa` | Health metrics — entry count, grade distribution, dedup status, type histogram |
| `atlas_health_export.hexa` | Export health report to a separate signals shard |
| `atlas_hot_shard.hexa` | Hot-shard promotion — frequently-read atoms get a dedicated cache shard |
| `atlas_map_export.hexa` | Map shard export — verified-only `[10*]+` subgraph extraction |
| `atlas_mmap.hexa` | mmap-backed scan — zero-copy linear traversal of large `.n6` files |
| `atlas_predict_cache.hexa` | Prediction cache for `~>` convergence claims (validates numeric targets) |
| `atlas_query.hexa` | Query engine — `@type` / `[grade]` / `<-` ancestry / `->` descendant filter |
| `atlas_scan_opt.hexa` | Scan-path optimizer — chooses between mmap / shard / hot-cache per query |

## Usage shape

```bash
hexa atlas_query.hexa --type=R --grade='10*' --domain=foundation
hexa atlas_health.hexa --file=atlas.n6
hexa atlas_absorb.hexa --append --file=atlas.n6 --entry='@R new_rel :: foundation [9]'
```

Each module ships a `--selftest` flag and prints its CLI surface with `--help`.

## Canonical atlas corpus (2026-05-22)

The canonical `atlas.n6` corpus and its `atlas.append.*.n6` shards live in the hexa-lang repo (single SSOT):

```
~/core/hexa-lang/n6/atlas.n6
~/core/hexa-lang/n6/atlas.append.*.n6
```

Point these algorithms at the canonical corpus by setting `HEXA_ATLAS_N6=~/core/hexa-lang/n6` and passing that directory as `<target_root>` (e.g. `hexa run atlas_absorb.hexa $HEXA_ATLAS_N6`). The `dist/atlas.hxc` binary sidecar is retired — the hexa-lang runtime parses `.n6` directly via the merger (PRs hexa-lang#312 / #314).

## Porting notes

The append path is the safety-critical surface — see `atlas_absorb.hexa` and the upstream `shared/blowup/lib/atlas_guard.hexa.inc` for the schema-validation contract. Any non-hexa implementation must preserve the dedup-on-`(type, id)` invariant and the byte-canonical write semantics described in [`../spec/n6.md` §Streaming](../spec/n6.md).

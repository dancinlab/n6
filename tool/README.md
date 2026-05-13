# `.n6` operational tools

The current toolchain lives entirely in the [`algorithms/`](../algorithms/) directory as hexa-lang modules — there is no separate dispatcher / linter / pilot CLI yet (unlike the sibling [`hxc` repo](https://github.com/dancinlab/hxc)).

Tool layer items planned for a future cycle:

- `n6_lint.hexa` — byte-canonical invariant linter (UTF-8 / LF / column-0 anchors / dedup-by-id)
- `n6_pilot.hexa` — measurement pilot (entry count · grade distribution · type histogram per file)
- `n6_consumer_adapter.hexa` — universal reader returning typed AST instead of raw lines
- `n6_omega_audit.hexa` — abstraction-exhaustion checker per `docs/omega_closure.md` (a)+(b)+(c)+(d) conditions

Until those land, the per-module CLIs under `algorithms/` cover the operational surface — see `algorithms/README.md`.

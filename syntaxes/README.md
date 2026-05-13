# `.n6` TextMate grammar

`n6.tmLanguage.json` — token rules for `.n6` files. Uses standard TextMate scopes so any theme renders without per-theme tuning.

## What it highlights

| Token | TextMate scope | Visual role |
|---|---|---|
| `#!/usr/bin/env n6` shebang | `comment.line.shebang` | File header |
| `# ── Section ──` divider | `markup.heading.section` | Section break |
| `# ═══` box divider | `markup.heading.box` | Major divider |
| `# ...` other | `comment.line.number-sign` | Plain comment |
| `@P @C @L @F @R @S @X @? @E` type prefix | `keyword.control.type` | Atom type |
| `<id>` atom identifier | `entity.name.atom` | Atom name |
| `:: <domain>` | `keyword.operator.domain` + `entity.name.namespace` | Domain tag |
| `[10*]` / `[9?]` / `[11*]` grade | `constant.numeric.grade` + `keyword.other.grade-marker` | Verification grade |
| `<-` / `->` / `=>` / `==` / `~>` / `\|>` / `!!` edges | `keyword.operator.edge` | Relation operators |
| `"..."` quoted prose | `string.quoted.double.prose` | Descriptive prose |
| `123` / `-1.5e6` | `constant.numeric` | Numeric literal |
| `+` / `-` / `*` / `^` / `(` `)` | `keyword.operator.arithmetic` | Expression operators |

## Local use without a published extension

### VS Code (manual install)

1. Copy to a local extensions folder:
   ```bash
   mkdir -p ~/.vscode/extensions/n6-local
   cp -r syntaxes ~/.vscode/extensions/n6-local/
   ```
2. Create `~/.vscode/extensions/n6-local/package.json`:
   ```json
   {
     "name": "n6-local",
     "version": "0.0.1",
     "engines": { "vscode": "^1.60.0" },
     "contributes": {
       "languages": [{ "id": "n6", "extensions": [".n6"] }],
       "grammars": [{
         "language": "n6",
         "scopeName": "source.n6",
         "path": "./syntaxes/n6.tmLanguage.json"
       }]
     }
   }
   ```
3. Restart VS Code → `.n6` files highlight automatically.

### Sublime Text / TextMate / Atom

Drop the `.tmLanguage.json` into the bundle/grammars directory of your editor.

## License

CC0-1.0 — free to copy into any extension/package.

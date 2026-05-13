## Examples

| File | Demonstrates |
|---|---|
| `01_primitives.n6` | `@P` primitive entries with `<-` / `->` / `==` / `=>` / `\|>` edges and section dividers |
| `02_relations.n6` | `@C` / `@F` / `@R` / `@L` mixed — constants, formulas, relations, qualitative laws |
| `03_crossings.n6` | `@X` cross-domain bridges + `@?` hypotheses + `~>` convergence + `!!` breakthrough + `@S` symmetry |

All examples are valid `.n6` v1:

- UTF-8, no BOM, LF line endings
- Headers at column 0, edges indented two spaces
- One atom per `@<type>` block; multiple edges allowed per atom
- Verification grade in trailing `[...]`

See [`../spec/n6.md`](../spec/n6.md) for the full grammar.

## Quick grep cookbook

```bash
# all verified core atoms
grep '^@.*\[1[01]\*\]' *.n6

# every breakthrough
grep '^@.*\[.*!\]' *.n6

# all open hypotheses
grep '^@?' *.n6

# all crossings (cross-domain bridges)
grep '^@X' *.n6
```

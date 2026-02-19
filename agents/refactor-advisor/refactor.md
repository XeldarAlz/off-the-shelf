Analyze the provided code for refactoring opportunities. Focus on practical improvements, not theoretical perfection.

Look for these code smells:
- **Long functions** (>30 lines) — suggest extraction points
- **Deep nesting** (>3 levels) — suggest early returns or guard clauses
- **Duplicated logic** — identify DRY violations and suggest abstractions
- **God objects/functions** — suggest responsibility splitting
- **Primitive obsession** — suggest type/class extraction
- **Feature envy** — methods that use another class's data more than their own
- **Dead code** — unused variables, unreachable branches, commented-out code

For each issue found:

1. **Identify** — Quote the specific code and name the smell
2. **Explain** — Why this is a problem (maintainability, testability, readability)
3. **Suggest** — Concrete refactoring with before/after snippets
4. **Risk** — Note any behavioral changes the refactoring might introduce

Prioritize suggestions by impact. Start with the highest-value, lowest-risk changes.

Do NOT suggest changes that are purely cosmetic (renaming for taste, reordering imports). Focus on structural improvements.

# Project Guidelines

## Structure
This is a monorepo with multiple packages/services.

```
packages/
  core/         # Shared core library
  api/          # Backend API service
  web/          # Frontend web application
  cli/          # CLI tool
```

## Conventions
- Each package has its own `package.json` (or equivalent) and README
- Shared code goes in `packages/core/`
- Cross-package imports use workspace protocol (e.g., `"@myorg/core": "workspace:*"`)
- Each package is independently testable and buildable
- Changes to `core` may affect all downstream packages — run full test suite

## Commands (from repo root)
- Install all: `npm install` (or `pnpm install`)
- Build all: `npm run build --workspaces`
- Test all: `npm test --workspaces`
- Build specific: `npm run build -w packages/api`
- Test specific: `npm test -w packages/web`
- Lint all: `npm run lint --workspaces`

## Package Dependencies
- `api` depends on `core`
- `web` depends on `core`
- `cli` depends on `core`
- `core` has no internal dependencies

## Guidelines
- When modifying `core`, check all dependent packages for breakage
- Keep package boundaries clean — no circular dependencies
- Shared types go in `core/types/`
- Each package owns its own configuration (tsconfig, eslint, etc.)
- Use consistent naming across packages
- PRs should scope changes to as few packages as possible

# Project Guidelines

## Stack
- TypeScript with strict mode
- Node.js runtime
- Package manager: npm

## Conventions
- Use named exports, not default exports
- Prefer `interface` over `type` for object shapes
- Use `const` by default, `let` when mutation is needed
- Error handling: throw typed errors, catch at boundaries
- Naming: camelCase for variables/functions, PascalCase for types/classes

## Testing
- Run tests: `npm test`
- Test framework: vitest
- Co-locate test files as `*.test.ts` next to source

## Commands
- Build: `npm run build`
- Lint: `npm run lint`
- Type check: `npx tsc --noEmit`

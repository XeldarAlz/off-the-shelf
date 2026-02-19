Generate comprehensive unit tests for the provided code.

Follow these steps:

1. **Identify the test framework** — Check the project for existing test files to match the framework (Jest, Vitest, pytest, Go testing, etc.). If none found, use the most common framework for the language.

2. **Analyze the function/module** — Identify:
   - Input parameters and their types
   - Return values
   - Side effects
   - Dependencies that need mocking
   - Error conditions

3. **Write tests covering**:
   - **Happy path** — Normal expected usage
   - **Edge cases** — Empty inputs, zero values, single elements, max values
   - **Boundary conditions** — Off-by-one, type boundaries
   - **Error cases** — Invalid input, missing dependencies, network failures
   - **Null/undefined** — Null inputs, missing optional parameters

4. **Test structure**:
   - Use descriptive test names that explain the expected behavior
   - Follow Arrange-Act-Assert pattern
   - One assertion per test when practical
   - Group related tests with describe/context blocks

5. **Place the test file** — Co-locate with the source file following project conventions. If no convention exists, use `*.test.*` next to the source.

Write the tests and save the file. Do not just print them.

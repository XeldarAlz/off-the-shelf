# Project Guidelines

## Stack
- Python 3.11+
- Package manager: uv (or pip)
- Linter/Formatter: ruff
- Type checker: mypy (strict mode)

## Conventions
- Use type hints on all public function signatures
- Prefer `dataclass` or `pydantic.BaseModel` over plain dicts for structured data
- Use `pathlib.Path` instead of `os.path`
- Naming: `snake_case` for functions/variables, `PascalCase` for classes
- Imports: standard library, third-party, local — separated by blank lines
- Use `from __future__ import annotations` for modern type syntax

## Testing
- Run tests: `pytest`
- Test framework: pytest
- Co-locate tests in `tests/` directory mirroring `src/` structure
- Name test files: `test_<module>.py`
- Use fixtures for setup, parametrize for variations
- Target coverage: 80%+

## Commands
- Lint: `ruff check .`
- Format: `ruff format .`
- Type check: `mypy .`
- Test: `pytest -v`
- Test with coverage: `pytest --cov`

## Error Handling
- Use specific exception types, not bare `except`
- Define custom exceptions in `exceptions.py`
- Log errors with `logging` module, not `print()`

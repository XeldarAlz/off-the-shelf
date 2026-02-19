# Contributing to off-the-shelf

Thanks for your interest in contributing! Here's how to get started.

## Development Setup

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/off-the-shelf.git
   cd off-the-shelf
   ```

2. Install development dependencies:
   ```bash
   # macOS
   brew install shellcheck bats-core jq fzf

   # Ubuntu/Debian
   sudo apt-get install shellcheck bats jq fzf
   ```

3. Run the linter:
   ```bash
   shellcheck ots install.sh
   ```

4. Run the tests:
   ```bash
   # Install bats helpers (first time only)
   git clone --depth 1 https://github.com/bats-core/bats-support.git test/test_helper/bats-support
   git clone --depth 1 https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert

   # Run tests
   bats test/*.bats
   ```

## Adding an Asset

1. Choose the right category:
   - `agents/` — Agent prompts and configurations
   - `skills/` — Slash command skills (`.claude/commands/`)
   - `claude-md/` — CLAUDE.md project templates
   - `hooks/` — Hook configurations
   - `mcp-configs/` — MCP server configurations

2. Create a directory: `<category>/<your-item-name>/`

3. Add a `manifest.json`:
   ```json
   {
     "name": "Your Item Name",
     "description": "What it does",
     "author": "your-github-username",
     "tags": ["relevant", "tags"],
     "install": {
       "source-file.md": ".claude/commands/your-item.md"
     },
     "postInstall": "Optional usage instructions"
   }
   ```

4. Add payload file(s) referenced in the `install` map.

5. Validate your manifest:
   ```bash
   jq empty <category>/<your-item>/manifest.json
   ```

## Manifest Validation

All manifests must:
- Be valid JSON
- Include required fields: `name`, `description`, `author`, `install`
- Have `install` as an object mapping source files to destinations
- Reference source files that exist in the same directory

## Code Style

- 2-space indentation
- UTF-8, LF line endings
- Functions: `snake_case`
- Follow existing patterns in the `ots` script
- Pass `shellcheck` without warnings

## Pull Request Workflow

1. Create a feature branch: `git checkout -b feat/your-feature`
2. Make your changes
3. Run linting and tests:
   ```bash
   shellcheck ots install.sh
   bats test/*.bats
   ```
4. Commit with conventional format:
   ```
   feat: add new skill for X
   fix: correct path validation edge case
   docs: update README examples
   test: add tests for uninstall command
   chore: update CI workflow
   ```
5. Push and open a PR against `main`

## Commit Conventions

We use [Conventional Commits](https://www.conventionalcommits.org/):

| Prefix | Use for |
|--------|---------|
| `feat:` | New features or assets |
| `fix:` | Bug fixes |
| `security:` | Security fixes |
| `docs:` | Documentation only |
| `test:` | Test additions or fixes |
| `chore:` | Tooling, CI, config changes |
| `refactor:` | Code restructuring |

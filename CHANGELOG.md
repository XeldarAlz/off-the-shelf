# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-12-19

### Added
- `ots self-update` command to update the CLI from upstream
- `ots uninstall` command with installation tracking ledger
- `--dry-run` flag for install to preview without writing files
- `validate_repo()` to enforce `owner/repo` format
- `validate_target_path()` for path traversal protection
- MIT LICENSE
- `.gitignore` and `.editorconfig`
- GitHub Actions CI (shellcheck, manifest validation, bats tests)
- bats-core test suite: security, config, install, and CLI tests
- CONTRIBUTING.md, CHANGELOG.md, SECURITY.md
- 14 new registry assets:
  - Agents: bug-fixer, refactor-advisor, security-auditor
  - Skills: explain-code, write-tests, pr-description, doc-generator
  - CLAUDE.md Templates: python-project, rust-project, monorepo
  - Hooks: format-on-edit, test-on-edit
  - MCP Configs: filesystem-mcp, postgres-mcp

### Changed
- Replaced `source` config loading with safe key=value parser (security fix)
- Added curl timeouts (`--connect-timeout 10 --max-time 30`) to all network calls
- Improved `fetch_manifest()` to distinguish network vs JSON parse failures
- Optimized search to pre-filter items by path before fetching manifests
- Improved `install.sh` to download to temp file and validate before installing
- Expanded README.md with full command reference and badges

### Security
- Config parser no longer executes arbitrary code via `source`
- Path traversal protection prevents `..`, absolute paths, and symlink escapes
- Network timeouts prevent hanging on unresponsive hosts

## [1.0.0] - 2025-12-01

### Added
- Initial release of off-the-shelf (ots)
- Interactive fzf browser for Claude Code assets
- Commands: browse, list, search, info, install, config, update, init
- Categories: agents, skills, claude-md, hooks, mcp-configs
- GitHub API integration with optional token auth
- Response caching with configurable TTL
- 5 starter assets:
  - Agent: code-reviewer
  - Skill: quick-commit
  - CLAUDE.md: typescript-project
  - Hook: lint-on-edit
  - MCP Config: github-mcp

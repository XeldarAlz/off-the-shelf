# off-the-shelf (ots)

[![CI](https://github.com/XeldarAlz/off-the-shelf/actions/workflows/ci.yml/badge.svg)](https://github.com/XeldarAlz/off-the-shelf/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.1.0-green.svg)](https://github.com/XeldarAlz/off-the-shelf)

A shared registry of ready-made Claude Code assets. Browse, search, and install agents, skills, CLAUDE.md templates, hooks, and MCP configs — straight from your terminal.

## Quick Start

```bash
# Install ots
curl -fsSL https://raw.githubusercontent.com/XeldarAlz/off-the-shelf/main/install.sh | bash

# Browse assets interactively
ots

# Or install directly
ots install skills/quick-commit
```

## Categories

| Category | Path | Description |
|----------|------|-------------|
| Agents | `agents/` | Agent prompts and configurations |
| Skills | `skills/` | Custom slash command skills (`.claude/commands/`) |
| CLAUDE.md | `claude-md/` | Project template files |
| Hooks | `hooks/` | Hook configurations for Claude Code |
| MCP Configs | `mcp-configs/` | MCP server configurations |

## Command Reference

| Command | Description | Example |
|---------|-------------|---------|
| `ots` / `ots browse` | Interactive fzf browser | `ots` |
| `ots list [category]` | List categories or items | `ots list skills` |
| `ots search <query>` | Search across all categories | `ots search "review"` |
| `ots info <cat/item>` | Show item details | `ots info agents/code-reviewer` |
| `ots install <cat/item>` | Install an item to current dir | `ots install skills/quick-commit` |
| `ots install <cat/item> --dry-run` | Preview install without writing | `ots install agents/reviewer --dry-run` |
| `ots uninstall <cat/item>` | Remove a previously installed item | `ots uninstall skills/quick-commit` |
| `ots config` | Configure registry settings | `ots config` |
| `ots update` | Clear cache and refresh | `ots update` |
| `ots self-update` | Update ots to the latest version | `ots self-update` |
| `ots init [dir]` | Create a new registry repo structure | `ots init ./my-registry` |
| `ots help` | Show help | `ots help` |
| `ots version` | Show version | `ots version` |

### Command Aliases

| Full | Aliases |
|------|---------|
| `browse` | `b` |
| `list` | `ls`, `l` |
| `search` | `s` |
| `info` | `i` |
| `install` | `in` |
| `uninstall` | `rm` |
| `config` | `cfg` |
| `update` | `u` |
| `self-update` | `selfupdate` |

## Authentication

For private registries or to avoid GitHub API rate limits, set a `GITHUB_TOKEN`:

```bash
# Option 1: Export in your shell profile
export GITHUB_TOKEN="ghp_your_token_here"

# Option 2: Set per-command
GITHUB_TOKEN="ghp_..." ots browse
```

The token needs `repo` scope for private repositories, or no scope at all for public repos (just increases rate limits).

## Manifest Schema

Each registry item is a directory containing a `manifest.json` and one or more payload files.

```json
{
  "name": "Human-readable name",
  "description": "What this item does",
  "author": "github-username",
  "tags": ["tag1", "tag2"],
  "install": {
    "source-file.md": ".claude/commands/target.md"
  },
  "postInstall": "Optional message shown after install"
}
```

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Display name |
| `description` | Yes | Short description |
| `author` | Yes | Author's GitHub username |
| `tags` | No | Array of search tags |
| `install` | Yes | Map of `source -> destination` paths |
| `postInstall` | No | Message shown after installation |

The `install` map defines source files (relative to the item directory) and their destinations (relative to the project root). Prefix destinations with `~` for paths relative to `$HOME`.

## Requirements

- `curl`, `jq`, `fzf`
- macOS or Linux (bash 3.2+)
- Optional: `GITHUB_TOKEN` for private repos

## Links

- [Contributing](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)
- [Security Policy](SECURITY.md)
- [License](LICENSE)

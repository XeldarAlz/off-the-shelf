# off-the-shelf (ots)

A shared registry of ready-made Claude Code assets. Browse, search, and install agents, skills, CLAUDE.md templates, hooks, and MCP configs — straight from your terminal.

## Categories

| Category | Path | Description |
|----------|------|-------------|
| Agents | `agents/` | Agent prompts and configurations |
| Skills | `skills/` | Custom slash command skills (`.claude/commands/`) |
| CLAUDE.md | `claude-md/` | Project template files |
| Hooks | `hooks/` | Hook configurations for Claude Code |
| MCP Configs | `mcp-configs/` | MCP server configurations |

## Install the CLI

```bash
curl -fsSL https://raw.githubusercontent.com/XeldarAlz/off-the-shelf/main/install.sh | bash
```

Or copy the `ots` script manually to somewhere in your `$PATH`.

## Usage

```bash
ots                              # Interactive fzf browser
ots list skills                  # List available skills
ots search "review"              # Search across all categories
ots install agents/code-reviewer # Install directly
ots info skills/quick-commit     # Show item details
```

On first run, it will ask for the registry repo — enter `XeldarAlz/off-the-shelf`.

## Adding Items

Each item is a folder inside its category containing:

- `manifest.json` — metadata and file mapping
- One or more files to install

### manifest.json format

```json
{
  "name": "Human-readable name",
  "description": "What this item does",
  "author": "XeldarAlz",
  "tags": ["tag1", "tag2"],
  "install": {
    "source-file.md": ".claude/commands/target.md"
  },
  "postInstall": "Optional message shown after install"
}
```

The `install` map defines `source -> destination` relative to the project root (or prefix with `~` for global paths).

## Requirements

- `curl`, `jq`, `fzf`
- macOS or Linux (bash 3.2+)
- `GITHUB_TOKEN` env var for private repos

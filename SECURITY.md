# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.1.x | Yes |
| 1.0.x | No |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly:

1. **Do not** open a public issue
2. Email: Open a private security advisory via [GitHub Security Advisories](https://github.com/XeldarAlz/off-the-shelf/security/advisories/new)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Expected Response Time

- **Acknowledgment**: Within 48 hours
- **Initial assessment**: Within 1 week
- **Fix release**: Within 2 weeks for critical issues

## Disclosure Policy

- We will coordinate disclosure timing with the reporter
- Credit will be given to the reporter (unless they prefer anonymity)
- Fixes will be released as patch versions

## Security Model

### What ots trusts

- **GitHub API responses**: ots fetches data from GitHub's API and raw content endpoints. It trusts that GitHub serves the correct content for the requested repository.
- **Local config file**: The config at `~/.config/ots/config` is parsed with a restricted key=value parser that only accepts `REPO` and `BRANCH` keys.

### What ots validates

- **Config values**: The `REPO` field is validated against a strict `owner/repo` regex pattern.
- **Install paths**: All target paths are checked for path traversal (`..`), absolute paths, backslashes, and symlink escapes.
- **Downloaded content**: Manifests are validated as proper JSON before caching.
- **Network timeouts**: All curl calls use `--connect-timeout 10 --max-time 30` to prevent hanging.

### What ots does NOT do

- ots does **not** execute downloaded code. It only writes files to disk at user-specified paths.
- ots does **not** run `postInstall` commands — it only displays them as informational messages.
- ots does **not** use `eval`, `source` on downloaded content, or any form of dynamic code execution on fetched data.

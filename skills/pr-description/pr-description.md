Generate a pull request description from the current branch.

1. Run `git log --oneline main..HEAD` to see the commits on this branch.
2. Run `git diff main...HEAD --stat` to see which files changed.
3. Run `git diff main...HEAD` to see the full diff.

Then generate a PR description in this format:

```
## Summary
<2-3 sentences describing what this PR does and why>

## Changes
- <bulleted list of key changes, grouped by area>

## Test Plan
- <how to verify these changes work>

## Notes
- <any migration steps, breaking changes, or things reviewers should know>
```

Guidelines:
- Be specific about what changed, not vague ("updated code" is bad, "added retry logic to API client" is good)
- Mention any files that were added or deleted
- If there are breaking changes, call them out prominently
- Keep it concise — reviewers should be able to understand the PR in 30 seconds

Print the description so it can be copied. Do not create the PR.

Review the current staged changes (git diff --cached) and provide structured feedback.

For each file changed, analyze:
1. **Correctness** - Logic errors, edge cases, potential bugs
2. **Security** - Injection risks, exposed secrets, unsafe patterns
3. **Performance** - Unnecessary allocations, N+1 queries, blocking calls
4. **Style** - Naming, consistency with surrounding code, readability

Format your review as:
- A 1-line summary of the overall change
- Per-file findings (skip files with no issues)
- A final verdict: APPROVE, REQUEST_CHANGES, or COMMENT

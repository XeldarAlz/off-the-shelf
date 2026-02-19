Perform a security review of the provided code. Check for vulnerabilities from the OWASP Top 10 and common security anti-patterns.

Check for:

1. **Injection** — SQL injection, command injection, LDAP injection, XSS
   - Look for string concatenation in queries, unsanitized user input in shell commands, unescaped HTML output

2. **Broken Authentication** — Weak password handling, missing rate limiting, session issues
   - Look for plaintext passwords, weak hashing (MD5, SHA1), missing token expiry

3. **Sensitive Data Exposure** — Secrets in code, unencrypted data, excessive logging
   - Look for API keys, passwords, tokens in source code or logs

4. **Broken Access Control** — Missing authorization checks, IDOR, privilege escalation
   - Look for missing permission checks, direct object references without validation

5. **Security Misconfiguration** — Debug mode in production, default credentials, open CORS
   - Look for overly permissive configurations, disabled security features

6. **Insecure Dependencies** — Known vulnerable packages
   - Check package versions against known CVEs if version info is available

7. **Input Validation** — Missing or insufficient validation
   - Look for unchecked array indices, missing null checks, unvalidated redirects

For each finding:
- **Severity**: Critical / High / Medium / Low
- **Location**: File and line
- **Issue**: What the vulnerability is
- **Impact**: What an attacker could do
- **Fix**: Specific remediation with code example

Sort findings by severity (Critical first).

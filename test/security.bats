#!/usr/bin/env bats

load test_helper/common

setup() {
  setup_common
}

teardown() {
  teardown_common
}

# ── Config Parser Security ──────────────────────────────────────────────────

@test "config parser ignores command injection in values" {
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" <<'EOF'
REPO="$(whoami)/evil"
BRANCH="main"
EOF

  # Source ots and load config
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    load_config
    echo "$REPO"
  '
  # The $() should be treated as literal text, not executed
  # The regex parser strips the $ and parens due to the character class
  [ "$status" -eq 0 ]
  # Should NOT contain the output of whoami
  [[ "$output" != *"$(whoami)"* ]] || [[ "$output" == *'$(whoami)'* ]]
}

@test "config parser ignores unknown keys" {
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" <<'EOF'
REPO="testuser/testrepo"
BRANCH="main"
EVIL_KEY="malicious"
PATH="/overwrite"
EOF

  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    load_config
    echo "REPO=$REPO"
    echo "BRANCH=$BRANCH"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"REPO=testuser/testrepo"* ]]
  [[ "$output" == *"BRANCH=main"* ]]
}

@test "config parser ignores comments" {
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" <<'EOF'
# This is a comment
REPO="testuser/testrepo"
# Another comment
BRANCH="dev"
EOF

  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    load_config
    echo "REPO=$REPO BRANCH=$BRANCH"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"REPO=testuser/testrepo"* ]]
  [[ "$output" == *"BRANCH=dev"* ]]
}

@test "config parser handles unquoted values" {
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" <<'EOF'
REPO=testuser/testrepo
BRANCH=main
EOF

  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    load_config
    echo "REPO=$REPO"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"REPO=testuser/testrepo"* ]]
}

# ── Path Traversal Protection ───────────────────────────────────────────────

@test "validate_target_path rejects .." {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_target_path "../etc/passwd" "/tmp/testdir"
  '
  [ "$status" -ne 0 ]
}

@test "validate_target_path rejects absolute paths" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_target_path "/etc/passwd" "/tmp/testdir"
  '
  [ "$status" -ne 0 ]
}

@test "validate_target_path rejects backslashes" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_target_path "foo\\bar" "/tmp/testdir"
  '
  [ "$status" -ne 0 ]
}

@test "validate_target_path accepts valid relative paths" {
  local test_base="${TEST_TEMP_DIR}/project"
  mkdir -p "$test_base"

  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_target_path ".claude/commands/test.md" "'"$test_base"'"
  '
  [ "$status" -eq 0 ]
}

# ── Curl Timeouts ───────────────────────────────────────────────────────────

@test "CURL_OPTS contains timeout settings" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    echo "$CURL_OPTS"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"--connect-timeout"* ]]
  [[ "$output" == *"--max-time"* ]]
}

# ── Repo Validation ─────────────────────────────────────────────────────────

@test "validate_repo rejects invalid formats" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_repo "not-a-valid-repo"
  '
  [ "$status" -ne 0 ]
}

@test "validate_repo rejects paths with slashes" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_repo "a/b/c"
  '
  [ "$status" -ne 0 ]
}

@test "validate_repo accepts valid owner/repo" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_repo "user/repo"
  '
  [ "$status" -eq 0 ]
}

@test "validate_repo accepts dots and hyphens" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    validate_repo "my-user.name/my-repo.name"
  '
  [ "$status" -eq 0 ]
}

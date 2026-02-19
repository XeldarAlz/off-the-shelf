#!/usr/bin/env bats

load test_helper/common

setup() {
  setup_common
}

teardown() {
  teardown_common
}

@test "dry-run flag does not create files" {
  local project_dir="${TEST_TEMP_DIR}/project"
  mkdir -p "$project_dir"

  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    DRY_RUN=true
    REPO="testuser/testrepo"

    # Mock fetch_manifest to return a test manifest
    fetch_manifest() {
      echo "{\"name\":\"Test\",\"install\":{\"test.md\":\".claude/commands/test.md\"},\"postInstall\":\"\"}"
    }
    # Mock fetch_file
    fetch_file() { echo "test content"; }

    cd "'"$project_dir"'"
    cmd_install "agents" "test" "project"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]
  [ ! -f "${project_dir}/.claude/commands/test.md" ]
}

@test "install creates target files" {
  local project_dir="${TEST_TEMP_DIR}/project"
  mkdir -p "$project_dir"

  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    REPO="testuser/testrepo"

    fetch_manifest() {
      echo "{\"name\":\"Test\",\"install\":{\"test.md\":\".claude/commands/test.md\"},\"postInstall\":\"\"}"
    }
    fetch_file() { echo "test content"; }

    cd "'"$project_dir"'"
    cmd_install "agents" "test" "project"
  '
  [ "$status" -eq 0 ]
  [ -f "${project_dir}/.claude/commands/test.md" ]
}

@test "install tracks files in ledger" {
  local project_dir="${TEST_TEMP_DIR}/project"
  mkdir -p "$project_dir"

  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    REPO="testuser/testrepo"

    fetch_manifest() {
      echo "{\"name\":\"Test\",\"install\":{\"test.md\":\".claude/commands/test.md\"},\"postInstall\":\"\"}"
    }
    fetch_file() { echo "test content"; }

    cd "'"$project_dir"'"
    cmd_install "agents" "test" "project"
  '
  [ "$status" -eq 0 ]
  [ -f "${HOME}/.config/ots/installed.json" ]

  run jq length "${HOME}/.config/ots/installed.json"
  [ "$output" -ge 1 ]
}

@test "uninstall removes tracked files" {
  local project_dir="${TEST_TEMP_DIR}/project"
  mkdir -p "$project_dir/.claude/commands"
  echo "test content" > "$project_dir/.claude/commands/test.md"

  # Create ledger entry
  mkdir -p "${HOME}/.config/ots"
  cat > "${HOME}/.config/ots/installed.json" <<EOF
[{"category":"agents","item":"test","path":"${project_dir}/.claude/commands/test.md","timestamp":"2025-01-01T00:00:00Z"}]
EOF

  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    echo "y" | cmd_uninstall "agents/test"
  '
  [ "$status" -eq 0 ]
  [ ! -f "${project_dir}/.claude/commands/test.md" ]
}

@test "uninstall with no records fails" {
  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    cmd_uninstall "agents/nonexistent"
  '
  [ "$status" -ne 0 ]
}

@test "install rejects path traversal in manifest targets" {
  local project_dir="${TEST_TEMP_DIR}/project"
  mkdir -p "$project_dir"

  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    REPO="testuser/testrepo"

    fetch_manifest() {
      echo "{\"name\":\"Evil\",\"install\":{\"evil.md\":\"../../etc/evil\"},\"postInstall\":\"\"}"
    }
    fetch_file() { echo "evil content"; }

    cd "'"$project_dir"'"
    cmd_install "agents" "evil" "project"
  '
  # Should complete but with 0 installed files (skipped)
  [[ "$output" == *"traversal"* ]] || [[ "$output" == *"Skipped"* ]]
}

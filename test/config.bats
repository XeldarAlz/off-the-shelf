#!/usr/bin/env bats

load test_helper/common

setup() {
  setup_common
}

teardown() {
  teardown_common
}

@test "load_config with no config file sets no REPO" {
  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    load_config
    echo "REPO=$REPO"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"REPO="* ]]
}

@test "save_config creates config file" {
  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    REPO="testuser/testrepo"
    BRANCH="dev"
    save_config
  '
  [ "$status" -eq 0 ]
  [ -f "$CONFIG_FILE" ]
}

@test "config round-trip preserves REPO and BRANCH" {
  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    REPO="myuser/myrepo"
    BRANCH="develop"
    save_config
    REPO=""
    BRANCH=""
    load_config
    echo "REPO=$REPO BRANCH=$BRANCH"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"REPO=myuser/myrepo"* ]]
  [[ "$output" == *"BRANCH=develop"* ]]
}

@test "load_config rejects invalid REPO format" {
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" <<'EOF'
REPO="invalid repo format spaces"
BRANCH="main"
EOF

  run bash -c '
    main() { :; }
    source "'"$OTS"'"
    load_config
  '
  [ "$status" -ne 0 ]
}

@test "save_config creates CONFIG_DIR if missing" {
  rm -rf "$CONFIG_DIR"

  run bash -c '
    export HOME="'"$HOME"'"
    main() { :; }
    source "'"$OTS"'"
    REPO="user/repo"
    BRANCH="main"
    save_config
  '
  [ "$status" -eq 0 ]
  [ -d "$CONFIG_DIR" ]
}

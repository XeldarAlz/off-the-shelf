#!/usr/bin/env bash

# Common test helper for ots bats tests

# Path to ots script
OTS="${BATS_TEST_DIRNAME}/../ots"

# Setup temp dirs and config for each test
setup_common() {
  export TEST_TEMP_DIR
  TEST_TEMP_DIR=$(mktemp -d "${BATS_TMPDIR}/ots-test.XXXXXX")

  export HOME="${TEST_TEMP_DIR}/home"
  mkdir -p "$HOME"

  export CONFIG_DIR="${HOME}/.config/ots"
  export CONFIG_FILE="${CONFIG_DIR}/config"
  export CACHE_DIR="${HOME}/.cache/ots"
  export INSTALL_LEDGER="${CONFIG_DIR}/installed.json"

  # Unset GITHUB_TOKEN to avoid hitting real API
  unset GITHUB_TOKEN
}

# Cleanup temp dirs after each test
teardown_common() {
  if [[ -d "${TEST_TEMP_DIR:-}" ]]; then
    rm -rf "$TEST_TEMP_DIR"
  fi
}

# Write a test config file
write_config() {
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" <<EOF
# ots configuration
REPO="${1:-testuser/testrepo}"
BRANCH="${2:-main}"
EOF
}

# Source ots functions in a controlled way
# This allows testing individual functions without running main()
source_ots() {
  # Override commands that would hit the network
  curl() { echo "MOCK_CURL_CALLED"; return 0; }
  export -f curl

  # Source just the functions (not main)
  # We do this by sourcing the file and overriding main
  (
    main() { :; }
    source "$OTS"
  )
}

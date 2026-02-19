#!/usr/bin/env bats

load test_helper/common

setup() {
  setup_common
}

teardown() {
  teardown_common
}

@test "help command shows usage" {
  run bash "$OTS" help
  [ "$status" -eq 0 ]
  [[ "$output" == *"off-the-shelf"* ]]
  [[ "$output" == *"COMMANDS"* ]]
  [[ "$output" == *"browse"* ]]
  [[ "$output" == *"install"* ]]
  [[ "$output" == *"uninstall"* ]]
  [[ "$output" == *"self-update"* ]]
  [[ "$output" == *"--dry-run"* ]]
}

@test "--help flag shows usage" {
  run bash "$OTS" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"COMMANDS"* ]]
}

@test "version command shows version" {
  run bash "$OTS" version
  [ "$status" -eq 0 ]
  [[ "$output" == *"ots v"* ]]
}

@test "--version flag shows version" {
  run bash "$OTS" --version
  [ "$status" -eq 0 ]
  [[ "$output" == *"ots v"* ]]
}

@test "unknown command exits with error" {
  run bash "$OTS" nonexistent-command
  [ "$status" -ne 0 ]
  [[ "$output" == *"Unknown command"* ]]
}

@test "search without query exits with error" {
  write_config
  run bash "$OTS" search
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "info without argument exits with error" {
  write_config
  run bash "$OTS" info
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "install without argument exits with error" {
  write_config
  run bash "$OTS" install
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "uninstall without argument exits with error" {
  run bash "$OTS" uninstall
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "version number matches expected format" {
  run bash "$OTS" version
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^ots\ v[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "list with no args shows categories" {
  write_config
  run bash "$OTS" list
  [ "$status" -eq 0 ]
  [[ "$output" == *"Categories"* ]]
  [[ "$output" == *"agents"* ]]
  [[ "$output" == *"skills"* ]]
  [[ "$output" == *"claude-md"* ]]
  [[ "$output" == *"hooks"* ]]
  [[ "$output" == *"mcp-configs"* ]]
}

@test "list with invalid category exits with error" {
  write_config
  run bash "$OTS" list nonexistent
  [ "$status" -ne 0 ]
  [[ "$output" == *"Unknown category"* ]]
}

# Project Guidelines

## Stack
- Rust (latest stable)
- Build system: cargo
- Edition: 2021

## Conventions
- Follow the Rust API Guidelines (https://rust-lang.github.io/api-guidelines/)
- Use `Result<T, E>` for fallible operations, not panics
- Prefer `thiserror` for library errors, `anyhow` for application errors
- Use `#[derive(...)]` generously: Debug, Clone, PartialEq at minimum
- Naming: `snake_case` for functions/variables, `PascalCase` for types, `SCREAMING_SNAKE` for constants
- Prefer iterators over manual loops
- Use `impl Trait` for function parameters where possible
- Document all public items with `///` doc comments

## Testing
- Run tests: `cargo test`
- Unit tests: `#[cfg(test)] mod tests` at bottom of each file
- Integration tests: `tests/` directory
- Use `assert_eq!`, `assert_ne!`, `assert!()`
- Test both success and error paths

## Commands
- Build: `cargo build`
- Test: `cargo test`
- Lint: `cargo clippy -- -D warnings`
- Format: `cargo fmt`
- Check: `cargo check`
- Doc: `cargo doc --open`

## Error Handling
- Define error types in `src/error.rs`
- Use `?` operator for error propagation
- Add context to errors with `.context()` (anyhow) or custom messages
- Never use `.unwrap()` in library code; ok in tests

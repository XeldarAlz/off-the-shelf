#!/usr/bin/env bash
set -euo pipefail

# off-the-shelf (ots) installer
# Usage: curl -fsSL https://raw.githubusercontent.com/XeldarAlz/off-the-shelf/main/install.sh | bash

REPO="XeldarAlz/off-the-shelf"
BRANCH="main"
INSTALL_DIR="${HOME}/.local/bin"
SCRIPT_NAME="ots"

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'
BOLD=$'\033[1m'
NC=$'\033[0m'

info() { echo "${CYAN}::${NC} $*"; }
success() { echo "${GREEN}ok${NC} $*"; }
die() { echo "${RED}error:${NC} $*" >&2; exit 1; }

echo "${BOLD}Installing off-the-shelf (ots)...${NC}"
echo ""

# Check for required tools
for cmd in curl jq; do
  command -v "$cmd" &>/dev/null || die "Required: ${cmd}. Install it first."
done

if ! command -v fzf &>/dev/null; then
  echo "${RED}fzf not found.${NC} Install it for interactive browsing:"
  echo "  brew install fzf      # macOS"
  echo "  apt install fzf       # Debian/Ubuntu"
  echo "  pacman -S fzf         # Arch"
  echo ""
  echo "Continuing install anyway (fzf needed at runtime)..."
fi

# Download the script to temp file, validate, then install
info "Downloading ots..."
mkdir -p "$INSTALL_DIR"
TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/ots-install.XXXXXX")
cleanup() { rm -f "$TEMP_FILE"; }
trap cleanup EXIT

curl -fsSL --connect-timeout 10 --max-time 30 \
  "https://raw.githubusercontent.com/${REPO}/${BRANCH}/ots" -o "$TEMP_FILE" || \
  die "Download failed. Check your network connection."

# Validate the downloaded script
if ! head -1 "$TEMP_FILE" | grep -q '^#!/usr/bin/env bash'; then
  die "Downloaded file is not a valid bash script"
fi

mv "$TEMP_FILE" "${INSTALL_DIR}/${SCRIPT_NAME}"
chmod +x "${INSTALL_DIR}/${SCRIPT_NAME}"

# Pre-configure the registry repo
mkdir -p "${HOME}/.config/ots"
cat > "${HOME}/.config/ots/config" <<EOF
# ots configuration
REPO="XeldarAlz/off-the-shelf"
BRANCH="main"
EOF

# Check if install dir is in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  echo ""
  echo "${BOLD}Add to your PATH:${NC}"
  echo ""
  SHELL_NAME=$(basename "$SHELL")
  case "$SHELL_NAME" in
    zsh)  echo "  echo 'export PATH=\"${INSTALL_DIR}:\$PATH\"' >> ~/.zshrc && source ~/.zshrc" ;;
    bash) echo "  echo 'export PATH=\"${INSTALL_DIR}:\$PATH\"' >> ~/.bashrc && source ~/.bashrc" ;;
    *)    echo "  export PATH=\"${INSTALL_DIR}:\$PATH\"" ;;
  esac
  echo ""
fi

success "Installed to ${INSTALL_DIR}/${SCRIPT_NAME}"
echo ""
echo "Run ${BOLD}ots${NC} to browse and install Claude Code assets."
echo "Run ${BOLD}ots help${NC} for all commands."

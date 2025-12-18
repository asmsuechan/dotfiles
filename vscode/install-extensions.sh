#!/usr/bin/env bash

#=============================================================================
# VSCode Extensions Installer
# Description: Manually install VSCode extensions from extensions.txt
#=============================================================================

set +e  # Don't exit on error (VSCode may crash)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTENSIONS_FILE="$SCRIPT_DIR/extensions.txt"

if [ ! -f "$EXTENSIONS_FILE" ]; then
    print_error "extensions.txt not found at $EXTENSIONS_FILE"
    exit 1
fi

if ! command -v code &> /dev/null; then
    print_error "VSCode CLI 'code' command not found"
    echo "Please install VSCode and ensure 'code' command is in your PATH"
    exit 1
fi

print_info "Installing VSCode extensions from $EXTENSIONS_FILE"
print_warning "Note: VSCode may crash during installation. This is a known issue."
print_info "If it crashes, just run this script again to continue."
echo ""

total=0
installed=0
failed=0

while IFS= read -r extension || [ -n "$extension" ]; do
    # Skip comments and empty lines
    [[ "$extension" =~ ^#.*$ ]] && continue
    [[ -z "$extension" ]] && continue

    total=$((total + 1))

    print_info "[$total] Installing: $extension"

    if code --install-extension "$extension" --force 2>&1 | grep -q "successfully installed"; then
        print_success "✓ Installed: $extension"
        installed=$((installed + 1))
    else
        print_warning "✗ Failed: $extension"
        failed=$((failed + 1))
    fi

    # Small delay to prevent rapid crashes
    sleep 0.5

done < "$EXTENSIONS_FILE"

echo ""
print_info "Installation Summary:"
echo "  Total: $total"
echo -e "  ${GREEN}Installed: $installed${NC}"
echo -e "  ${YELLOW}Failed: $failed${NC}"

if [ $failed -gt 0 ]; then
    echo ""
    print_warning "Some extensions failed to install. You can:"
    echo "  1. Run this script again: ./vscode/install-extensions.sh"
    echo "  2. Install manually from VSCode: Extensions panel"
fi

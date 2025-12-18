#!/usr/bin/env bash

#=============================================================================
# Nerd Font Installer and Setup Guide
#=============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_step() {
    echo -e "${GREEN}➜${NC} $1"
}

print_header "Nerd Font Installation & Configuration"

# Check if Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
    print_error "Homebrew not found. Please install Homebrew first."
    echo "Visit: https://brew.sh"
    exit 1
fi

print_success "Homebrew found: $(which brew)"
echo ""

# Check if any Nerd Font is already installed
print_info "Checking for installed Nerd Fonts..."
INSTALLED_FONTS=""
if brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
    INSTALLED_FONTS="${INSTALLED_FONTS}JetBrains Mono Nerd Font\n"
fi
if brew list --cask font-fira-code-nerd-font >/dev/null 2>&1; then
    INSTALLED_FONTS="${INSTALLED_FONTS}Fira Code Nerd Font\n"
fi
if brew list --cask font-hack-nerd-font >/dev/null 2>&1; then
    INSTALLED_FONTS="${INSTALLED_FONTS}Hack Nerd Font\n"
fi

if [ -n "$INSTALLED_FONTS" ]; then
    print_success "Found installed Nerd Fonts:"
    echo -e "$INSTALLED_FONTS"
else
    print_warning "No Nerd Fonts found. Installing JetBrains Mono Nerd Font..."
    echo ""

    print_step "Installing font..."
    if brew install --cask font-jetbrains-mono-nerd-font; then
        print_success "JetBrains Mono Nerd Font installed successfully!"
    else
        print_error "Failed to install font"
        exit 1
    fi
fi

echo ""
print_header "iTerm2 Configuration Steps"

print_warning "You MUST configure iTerm2 to use the Nerd Font!"
echo ""

print_step "Step 1: Open iTerm2 Preferences"
echo "  Press: ⌘, (Command + Comma)"
echo ""

print_step "Step 2: Go to Profiles → Text"
echo "  Click on the 'Profiles' tab"
echo "  Click on the 'Text' tab"
echo ""

print_step "Step 3: Change Font"
echo "  In the 'Font' section, click 'Change Font'"
echo "  Select: ${CYAN}JetBrainsMono Nerd Font${NC}"
echo "  Size: ${CYAN}13${NC} or ${CYAN}14${NC} (recommended)"
echo ""

print_step "Step 4: Enable Ligatures"
echo "  ✅ Check: 'Use ligatures'"
echo ""

print_step "Step 5: Configure Non-ASCII Font (IMPORTANT!)"
echo "  ✅ Check: 'Use a different font for non-ASCII text'"
echo "  Click 'Change Font' under this option"
echo "  Select: ${CYAN}JetBrainsMono Nerd Font${NC} (same as before)"
echo "  ${YELLOW}This step is crucial for icon display!${NC}"
echo ""

print_header "Verification"

echo "After configuring iTerm2:"
echo "1. ${CYAN}Close this terminal completely${NC} (⌘Q to quit iTerm2)"
echo "2. ${CYAN}Reopen iTerm2${NC}"
echo "3. Run: ${CYAN}./test-icons.sh${NC}"
echo ""
echo "You should see:"
echo "  ✓ File icons like:       (folder)"
echo "  ✓ Arrow symbols like: → ← ↑ ↓"
echo "  ✓ Git branch icon:     "
echo ""

print_header "Common Issues"

echo "❌ Still seeing [?] or boxes?"
echo ""
echo "1. Font name must be exact:"
echo "   ✓ Correct: ${GREEN}JetBrainsMono Nerd Font${NC}"
echo "   ✗ Wrong:   ${RED}JetBrains Mono${NC}"
echo "   ✗ Wrong:   ${RED}JetBrainsMono${NC}"
echo ""
echo "2. Non-ASCII font MUST be set:"
echo "   Icons are non-ASCII characters"
echo "   ${YELLOW}Both regular AND non-ASCII fonts must be Nerd Font!${NC}"
echo ""
echo "3. Restart iTerm2 completely:"
echo "   Preferences changes may not take effect until restart"
echo ""

print_header "Alternative Fonts"

echo "If you prefer a different font:"
echo ""
echo "Fira Code Nerd Font:"
echo "  ${CYAN}brew install --cask font-fira-code-nerd-font${NC}"
echo ""
echo "Hack Nerd Font:"
echo "  ${CYAN}brew install --cask font-hack-nerd-font${NC}"
echo ""
echo "See all available: ${CYAN}brew search nerd-font${NC}"
echo ""

print_success "Installation guide complete!"
echo ""
echo "Next: Configure iTerm2 following the steps above, then test with:"
echo "  ${CYAN}./test-icons.sh${NC}"
echo ""

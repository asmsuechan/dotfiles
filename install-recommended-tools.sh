#!/usr/bin/env bash

#=============================================================================
# Recommended Modern Tools Installer
# Description: Install additional modern CLI tools for better productivity
#=============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

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

install_tool() {
    local tool=$1
    local description=$2

    if command -v "$tool" >/dev/null 2>&1; then
        print_success "$tool already installed"
    else
        print_info "Installing $tool - $description"
        if brew install "$tool"; then
            print_success "$tool installed"
        else
            print_warning "Failed to install $tool"
        fi
    fi
}

print_header "Recommended Modern Tools Installer"

echo "This will install additional modern CLI tools to enhance your workflow."
echo ""

#=============================================================================
# Category 1: Navigation & History
#=============================================================================
print_header "Navigation & History Tools"

echo "📍 zoxide - Smarter cd command (learns your habits)"
echo "   Usage: z <directory-name> or zi (interactive)"
install_tool "zoxide" "smarter cd"

echo ""
echo "📜 atuin - Better shell history (sync across machines)"
echo "   Usage: Ctrl+R for better history search"
install_tool "atuin" "shell history replacement"

echo ""
echo "🔧 thefuck - Auto-correct previous commands"
echo "   Usage: fuck (after a failed command)"
install_tool "thefuck" "command correction"

#=============================================================================
# Category 2: Git & GitHub
#=============================================================================
print_header "Git & GitHub Tools"

echo "🌳 lazygit - Terminal UI for git"
echo "   Usage: lazygit"
install_tool "lazygit" "git TUI"

echo ""
echo "🐙 tig - Text-mode interface for git"
echo "   Usage: tig (better git log)"
install_tool "tig" "git TUI"

echo ""
echo "📊 git-delta - Better git diff"
echo "   Usage: Already configured in .gitconfig"
install_tool "git-delta" "syntax-highlighting pager for git"

#=============================================================================
# Category 3: Docker & Containers
#=============================================================================
print_header "Docker & Container Tools"

echo "🐳 lazydocker - Terminal UI for docker"
echo "   Usage: lazydocker"
install_tool "lazydocker" "docker TUI"

echo ""
echo "📦 dive - Explore docker image layers"
echo "   Usage: dive <image-name>"
install_tool "dive" "docker image explorer"

#=============================================================================
# Category 4: Documentation & Help
#=============================================================================
print_header "Documentation Tools"

echo "📚 tldr - Simplified man pages"
echo "   Usage: tldr <command>"
install_tool "tldr" "simplified man pages"

echo ""
echo "📖 cheat - Interactive cheatsheets"
echo "   Usage: cheat <command>"
install_tool "cheat" "command cheatsheets"

echo ""
echo "✨ glow - Markdown renderer in terminal"
echo "   Usage: glow README.md"
install_tool "glow" "markdown viewer"

#=============================================================================
# Category 5: System & Monitoring
#=============================================================================
print_header "System Monitoring Tools"

echo "💻 btop - Modern system monitor"
echo "   Usage: btop"
install_tool "btop" "system monitor"

echo ""
echo "🖥️  fastfetch - Fast system info"
echo "   Usage: fastfetch"
install_tool "fastfetch" "system info"

echo ""
echo "🔍 procs - Modern ps replacement"
echo "   Usage: procs"
install_tool "procs" "process viewer"

#=============================================================================
# Category 6: JSON & Data Tools
#=============================================================================
print_header "Data Processing Tools"

echo "🔧 jq - JSON processor (already installed)"
install_tool "jq" "JSON processor"

echo ""
echo "📋 yq - YAML/XML processor"
echo "   Usage: yq '.key' file.yaml"
install_tool "yq" "YAML processor"

echo ""
echo "🔍 fx - Interactive JSON viewer"
echo "   Usage: cat data.json | fx"
install_tool "fx" "JSON viewer"

#=============================================================================
# Category 7: Network & HTTP
#=============================================================================
print_header "Network Tools"

echo "🌐 httpie - User-friendly HTTP client"
echo "   Usage: http GET api.example.com"
install_tool "httpie" "HTTP client"

echo ""
echo "⚡ curlie - curl with httpie-like UI"
echo "   Usage: curlie GET api.example.com"
install_tool "curlie" "curl frontend"

#=============================================================================
# Category 8: File Tools
#=============================================================================
print_header "File Management Tools"

echo "🔎 broot - Interactive directory tree"
echo "   Usage: br"
install_tool "broot" "directory navigation"

echo ""
echo "🗜️  zoxide - Already installed above"

echo ""
echo "📁 lsd - Modern ls (alternative to eza)"
echo "   Usage: lsd -la"
install_tool "lsd" "ls alternative"

#=============================================================================
# Configure installed tools
#=============================================================================
print_header "Configuring Tools"

# Configure zoxide
if command -v zoxide >/dev/null 2>&1; then
    print_info "Adding zoxide configuration to .zprofile"
    if ! grep -q "zoxide init" ~/.zprofile; then
        cat >> ~/.zprofile << 'EOF'

# zoxide - smarter cd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
EOF
        print_success "zoxide configured (use 'z' command)"
    fi
fi

# Configure atuin
if command -v atuin >/dev/null 2>&1; then
    print_info "Adding atuin configuration to .zprofile"
    if ! grep -q "atuin init" ~/.zprofile; then
        cat >> ~/.zprofile << 'EOF'

# atuin - better shell history
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi
EOF
        print_success "atuin configured (Ctrl+R for search)"
    fi
fi

# Configure thefuck
if command -v thefuck >/dev/null 2>&1; then
    print_info "Adding thefuck configuration to .zprofile"
    if ! grep -q "thefuck --alias" ~/.zprofile; then
        cat >> ~/.zprofile << 'EOF'

# thefuck - command correction
if command -v thefuck >/dev/null 2>&1; then
  eval "$(thefuck --alias)"
fi
EOF
        print_success "thefuck configured (type 'fuck' after wrong command)"
    fi
fi

#=============================================================================
# Create aliases
#=============================================================================
print_header "Creating Useful Aliases"

ALIASES_FILE="$HOME/.zsh_aliases"

cat > "$ALIASES_FILE" << 'EOF'
#=============================================================================
# Recommended Tool Aliases
#=============================================================================

# Git tools
alias lg='lazygit'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --all'

# Docker tools
alias lzd='lazydocker'
alias dps='docker ps'
alias dimg='docker images'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System info
alias sysinfo='fastfetch'
alias proc='procs'

# JSON/YAML
alias jqp='jq . -C | less -R'  # Pretty print JSON with pager
alias yqp='yq . -C | less -R'  # Pretty print YAML with pager

# Network
alias myip='curl -s https://api.ipify.org && echo'
alias ports='netstat -tulanp'

# Quick edits
alias zshconfig='vim ~/.zshrc'
alias zprofile='vim ~/.zprofile'
alias vimconfig='vim ~/.vimrc'

# Shortcuts
alias c='clear'
alias h='history'
alias ports='lsof -i -P | grep LISTEN'

# Better defaults
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# File listing (if eza not available)
if ! command -v eza >/dev/null 2>&1; then
  if command -v lsd >/dev/null 2>&1; then
    alias ls='lsd'
    alias l='lsd -la'
    alias ll='lsd -l'
    alias tree='lsd --tree'
  fi
fi
EOF

# Add sourcing to .zprofile if not already there
if ! grep -q "source.*zsh_aliases" ~/.zprofile; then
    echo "" >> ~/.zprofile
    echo "# Load custom aliases" >> ~/.zprofile
    echo "[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases" >> ~/.zprofile
    print_success "Aliases file created and configured"
fi

#=============================================================================
# Completion
#=============================================================================
print_header "Installation Complete!"

echo "Installed tools summary:"
echo ""
echo "Navigation & History:"
echo "  • zoxide (z <dir>)       - Smart directory jumping"
echo "  • atuin (Ctrl+R)         - Better history search"
echo "  • thefuck (fuck)         - Command correction"
echo ""
echo "Git & Development:"
echo "  • lazygit (lg)           - Git TUI"
echo "  • tig                    - Git browser"
echo ""
echo "Docker:"
echo "  • lazydocker (lzd)       - Docker TUI"
echo "  • dive                   - Image explorer"
echo ""
echo "Documentation:"
echo "  • tldr                   - Quick help"
echo "  • glow                   - Markdown viewer"
echo ""
echo "System:"
echo "  • btop                   - System monitor"
echo "  • fastfetch (sysinfo)    - System info"
echo "  • procs (proc)           - Process viewer"
echo ""
echo "Data Tools:"
echo "  • jq/yq/fx               - JSON/YAML processing"
echo ""
echo "Network:"
echo "  • httpie (http)          - HTTP client"
echo ""

print_warning "Restart your terminal or run: source ~/.zprofile"
echo ""
echo "Try these commands:"
echo "  ${CYAN}z dotfiles${NC}          - Jump to dotfiles directory"
echo "  ${CYAN}lg${NC}                  - Open lazygit"
echo "  ${CYAN}tldr git${NC}            - Quick git help"
echo "  ${CYAN}sysinfo${NC}             - Show system info"
echo "  ${CYAN}fuck${NC}                - Fix last command"
echo ""

#!/usr/bin/env bash

#=============================================================================
# Dotfiles Setup Script
# Author: asmsuechan
# Description: Automated setup script for modern development environment
#=============================================================================

set -e  # Exit on error

# Check bash version (need 4.0+ for associative arrays)
if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "This script requires bash 4.0 or higher."
    echo "Current version: ${BASH_VERSION}"
    echo "On macOS, install with: brew install bash"
    echo ""
    echo "Continuing with alternative method..."
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
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

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

#=============================================================================
# Main Setup
#=============================================================================

print_info "Starting dotfiles setup..."
echo ""

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
print_info "Dotfiles directory: $DOTFILES_DIR"
echo ""

#=============================================================================
# 1. Install Homebrew (macOS)
#=============================================================================
print_info "Checking for Homebrew..."

# Set Homebrew PATH if it exists
if [ -d "$HOME/homebrew" ]; then
    export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH"
    print_info "Using Homebrew at: $HOME/homebrew"
elif [ -d "/opt/homebrew" ]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    print_info "Using Homebrew at: /opt/homebrew"
elif [ -d "/usr/local/Homebrew" ]; then
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    print_info "Using Homebrew at: /usr/local"
fi

if ! command_exists brew; then
    print_warning "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Set PATH after installation
    if [ -d "$HOME/homebrew" ]; then
        export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH"
    elif [ -d "/opt/homebrew" ]; then
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    elif [ -d "/usr/local/Homebrew" ]; then
        export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    fi

    print_success "Homebrew installed"
else
    print_success "Homebrew already installed at: $(which brew)"
fi
echo ""

#=============================================================================
# 2. Install Modern CLI Tools
#=============================================================================
print_info "Installing modern CLI tools..."

# Essential tools
tools=(
    "zsh"           # Modern shell
    "starship"      # Modern prompt
    "eza"           # Modern ls (exa fork)
    "bat"           # Modern cat
    "fd"            # Modern find
    "ripgrep"       # Modern grep
    "fzf"           # Fuzzy finder
    "git-delta"     # Modern git diff
    "btop"          # Modern top
    "dust"          # Modern du
    "zoxide"        # Smarter cd
    "gh"            # GitHub CLI
    "jq"            # JSON processor
    "tree"          # Directory tree view
)

for tool in "${tools[@]}"; do
    if command_exists "$tool"; then
        print_success "$tool already installed"
    else
        print_info "Installing $tool..."
        brew install "$tool"
        print_success "$tool installed"
    fi
done
echo ""

#=============================================================================
# 3. Install Development Tools
#=============================================================================
print_info "Installing development tools..."

dev_tools=(
    "direnv"        # Environment management
    "rbenv"         # Ruby version management
    "nodenv"        # Node.js version management
    "pyenv"         # Python version management
    "go"            # Go programming language
    "rust"          # Rust programming language
)

for tool in "${dev_tools[@]}"; do
    if command_exists "$tool"; then
        print_success "$tool already installed"
    else
        print_info "Installing $tool..."
        brew install "$tool"
        print_success "$tool installed"
    fi
done
echo ""

#=============================================================================
# 4. Setup Symbolic Links
#=============================================================================
print_info "Creating symbolic links..."

# Create necessary directories
mkdir -p "$HOME/.config"

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        print_warning "$target is already a symlink, skipping..."
    elif [ -f "$target" ] || [ -d "$target" ]; then
        print_warning "$target already exists, backing up to ${target}.backup"
        mv "$target" "${target}.backup"
        ln -s "$source" "$target"
        print_success "Created symlink: $target -> $source"
    else
        ln -s "$source" "$target"
        print_success "Created symlink: $target -> $source"
    fi
}

# Create symlinks for each dotfile
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

echo ""

#=============================================================================
# 5. Install zplug (ZSH plugin manager)
#=============================================================================
print_info "Setting up zplug..."

# Check if zplug is installed via Homebrew
if brew list zplug &>/dev/null; then
    print_success "zplug is installed via Homebrew"
    BREW_ZPLUG_PATH="$(brew --prefix zplug)"

    # Create symlink if it doesn't exist
    if [ ! -d "$HOME/.zplug" ]; then
        ln -s "$BREW_ZPLUG_PATH" "$HOME/.zplug"
        print_success "Created symlink: $HOME/.zplug -> $BREW_ZPLUG_PATH"
    else
        print_success "zplug already configured at $HOME/.zplug"
    fi
elif [ ! -d "$HOME/.zplug" ]; then
    print_info "Installing zplug to $HOME/.zplug..."
    git clone https://github.com/zplug/zplug "$HOME/.zplug"
    print_success "zplug installed to $HOME/.zplug"
else
    print_success "zplug already installed at $HOME/.zplug"
fi
echo ""

#=============================================================================
# 6. Install Vim Plugin Manager (vim-plug)
#=============================================================================
print_info "Setting up vim-plug..."
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    print_info "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    print_success "vim-plug installed"
else
    print_success "vim-plug already installed"
fi
echo ""

#=============================================================================
# 7. Install Vim Plugins
#=============================================================================
print_info "Installing Vim plugins..."
vim +PlugInstall +qall
print_success "Vim plugins installed"
echo ""

#=============================================================================
# 8. VSCode Setup (if installed)
#=============================================================================
print_info "Checking for VSCode..."
if command_exists code; then
    print_info "Setting up VSCode..."

    # Create VSCode config directory if it doesn't exist
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_USER_DIR"

    # Symlink settings
    if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
        print_warning "VSCode settings.json already exists, backing up..."
        mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup"
    fi
    ln -s "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    print_success "VSCode settings linked"

    # Install extensions
    if [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
        print_info "Installing VSCode extensions..."
        print_warning "Note: VSCode may crash during extension installation. This is a known VSCode issue."
        print_info "You can manually install extensions later using: cat vscode/extensions.txt | grep -v '^#' | xargs -L 1 code --install-extension"

        # Ask user if they want to proceed
        read -p "Do you want to install VSCode extensions now? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Temporarily disable exit on error for extension installation
            set +e

            while IFS= read -r extension || [ -n "$extension" ]; do
                # Skip comments and empty lines
                [[ "$extension" =~ ^#.*$ ]] && continue
                [[ -z "$extension" ]] && continue

                print_info "Installing: $extension"
                if code --install-extension "$extension" --force 2>/dev/null; then
                    print_success "Installed: $extension"
                else
                    print_warning "Failed to install: $extension (you can install it manually later)"
                fi
            done < "$DOTFILES_DIR/vscode/extensions.txt"

            # Re-enable exit on error
            set -e
            print_success "VSCode extension installation completed (some may have failed)"
        else
            print_info "Skipping VSCode extension installation"
        fi
    fi
else
    print_warning "VSCode not found, skipping VSCode setup"
fi
echo ""

#=============================================================================
# 9. Set ZSH as default shell
#=============================================================================
print_info "Setting ZSH as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    print_success "Default shell changed to ZSH"
else
    print_success "ZSH is already the default shell"
fi
echo ""

#=============================================================================
# 10. Install Nerd Fonts (Required for icons)
#=============================================================================
print_info "Installing Nerd Fonts for icon support..."

if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
    print_success "JetBrains Mono Nerd Font already installed"
elif brew list --cask font-fira-code-nerd-font &>/dev/null; then
    print_success "Fira Code Nerd Font already installed"
elif brew list --cask font-hack-nerd-font &>/dev/null; then
    print_success "Hack Nerd Font already installed"
else
    print_info "Installing JetBrains Mono Nerd Font..."
    brew install --cask font-jetbrains-mono-nerd-font
    print_success "JetBrains Mono Nerd Font installed"
fi
echo ""

#=============================================================================
# Completion
#=============================================================================
echo ""
print_success "Setup complete!"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Configure iTerm2 to use Nerd Font:"
echo "   - Press ⌘, to open Preferences"
echo "   - Go to Profiles → Text"
echo "   - Set Font to: JetBrainsMono Nerd Font (size 13-14)"
echo "   - ✅ Check 'Use ligatures'"
echo "   - ✅ Check 'Use a different font for non-ASCII text'"
echo "   - Set Non-ASCII Font to: JetBrainsMono Nerd Font"
echo ""
echo "2. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "3. Test icons: ./test-icons.sh"
echo ""
echo "4. Enjoy your modern development environment!"
echo ""

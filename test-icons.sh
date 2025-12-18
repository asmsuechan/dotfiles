#!/bin/bash

echo "=== Nerd Font Icon Test ==="
echo ""
echo "File icons (should show icons, not boxes/[?]):"
echo "   Folder"
echo "   JavaScript (.js)"
echo "   Python (.py)"
echo "   Ruby (.rb)"
echo "   Go (.go)"
echo "   Rust (.rs)"
echo "   Git"
echo "   File"
echo ""
echo "Arrow icons:"
echo "          "
echo ""
echo "Branch icon:"
echo "   "
echo ""
echo "If you see actual icons above (not boxes □ or [?]), Nerd Font is working!"
echo "If you see boxes or question marks, you need to install and configure a Nerd Font."
echo ""
echo "Current terminal font info:"
echo "  Check iTerm2 → Preferences → Profiles → Text → Font"
echo "  It should be set to: JetBrainsMono Nerd Font (or another Nerd Font)"
echo ""
echo "Testing with eza (if installed):"
if command -v eza >/dev/null 2>&1; then
    echo ""
    eza -l --icons ~/.zshrc ~/.vimrc 2>/dev/null | head -10
else
    echo "eza not installed yet (run: brew install eza)"
fi

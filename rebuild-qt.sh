#!/usr/bin/env bash

set -e

echo "=== Qt Version Mismatch Recovery ==="
echo ""

# Rebuild quickshell-git from AUR
echo "[1/2] Rebuilding quickshell-git from AUR..."
cd /tmp
rm -rf quickshell-git
git clone https://aur.archlinux.org/quickshell-git.git
cd quickshell-git
makepkg -si

echo ""
echo "[2/2] Rebuilding caelestia-shell..."
cd ~/.config/quickshell/caelestia
cmake -B build -G Ninja
ninja -C build
sudo ninja -C build install

echo ""
echo "=== Rebuild complete ==="
echo "Testing with: qs -c caelestia &"

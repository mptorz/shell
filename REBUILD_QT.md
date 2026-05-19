# Qt Version Mismatch Recovery

When Qt updates on your system, `quickshell-git` and `caelestia-shell` may lose binary compatibility and crash on startup with:

```
WARN: Quickshell was built against Qt 6.X.Y but the system has updated to Qt 6.X.Z without rebuilding the package.
```

## Quick Fix

Run the rebuild script:
```bash
cd ~/.config/quickshell/caelestia
./rebuild-qt.sh
```

Or manually rebuild both packages:

```bash
# Rebuild quickshell-git from AUR
cd /tmp && rm -rf quickshell-git && git clone https://aur.archlinux.org/quickshell-git.git && cd quickshell-git && makepkg -si

# Rebuild caelestia-shell fork
cd ~/.config/quickshell/caelestia && cmake -B build -G Ninja && ninja -C build && sudo ninja -C build install
```

## Why This Happens

- `quickshell-git` and `caelestia-shell` are pinned in `/etc/pacman.conf` to prevent auto-updates
- When Qt updates via `pacman -Syu`, these packages don't rebuild automatically
- The binaries become incompatible with the new Qt libs
- A full recompile against the new Qt version fixes it

## Test

After rebuilding:
```bash
qs -c caelestia &
```

Should start without the Qt version warning.

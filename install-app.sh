#!/usr/bin/env bash
set -euo pipefail

source_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
plugin_dir="$HOME/.config/omarchy/plugins/io.github.cjgarcia1229.monitor-layout"
applications_dir="$HOME/.local/share/applications"
icons_dir="$HOME/.local/share/icons/hicolor/scalable/apps"

mkdir -p "$plugin_dir" "$applications_dir" "$icons_dir"
if [[ $(realpath "$source_dir") != $(realpath "$plugin_dir") ]]; then
  cp -a "$source_dir/." "$plugin_dir/"
fi
chmod +x "$plugin_dir/launch.sh" "$plugin_dir/monitor_layout.py"

sed "s|@PLUGIN_DIR@|$plugin_dir|g" \
  "$source_dir/io.github.cjgarcia1229.monitor-layout.desktop.in" \
  > "$applications_dir/io.github.cjgarcia1229.monitor-layout.desktop"
cp "$source_dir/omarchy-monitor-layout.svg" "$icons_dir/omarchy-monitor-layout.svg"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$applications_dir"
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
  gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" >/dev/null 2>&1 || true
fi
if command -v omarchy-shell >/dev/null 2>&1; then
  omarchy-shell shell rescanPlugins >/dev/null 2>&1 || true
fi

echo "Installed Monitor Layout as an Omarchy plugin and desktop application."

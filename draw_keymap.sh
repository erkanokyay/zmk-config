#!/usr/bin/env bash
# Generates PNG images for each keymap layer into img/
# Requires: uv / uvx and rsvg-convert (librsvg)
set -euo pipefail
cd "$(dirname "$0")"

KEYMAP=config/sofle_choc_pro.keymap
LAYOUT=boards/arm/sofle_choc_pro/sofle_choc_pro-layouts.dtsi
KD=(uvx --from keymap-drawer keymap -c keymap_drawer.config.yaml)

mkdir -p img
"${KD[@]}" parse -z "$KEYMAP" -o img/keymap.yaml

# Extract layer names dynamically from the parsed YAML using python
LAYERS=$(python3 -c "import yaml; data = yaml.safe_load(open('img/keymap.yaml')); print(' '.join(data.get('layers', {}).keys()))")

draw() {
  local out=$1; shift
  "${KD[@]}" draw -d "$LAYOUT" img/keymap.yaml "$@" -o "img/$out.svg"
  rsvg-convert -z 2 -b white "img/$out.svg" -o "img/$out.png"
  rm "img/$out.svg"
  echo "Generated img/$out.png"
}

draw keymap
for layer in $LAYERS; do
  draw "keymap-$layer" -s "$layer"
done

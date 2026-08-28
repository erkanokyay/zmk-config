#!/usr/bin/env bash
# Generates PNG images for each keymap layer into img/
# Requires: uv / uvx and rsvg-convert (librsvg)
set -euo pipefail
cd "$(dirname "$0")"

KEYMAP=config/sofle_choc_pro.keymap
LAYOUT=boards/arm/sofle_choc_pro/sofle_choc_pro-layouts.dtsi

# Inlined config for keymap-drawer
CONFIG_FILE=$(mktemp --suffix=.yaml)
trap 'rm -f "$CONFIG_FILE"' EXIT
cat << 'CFG' > "$CONFIG_FILE"
parse_config:
  raw_binding_map:
    "&caps_word": CAPS
    "&studio_unlock": STUDIO
    "&bootloader": BOOT
    "&sys_reset": RESET
CFG

KD=(uvx --from keymap-drawer keymap -c "$CONFIG_FILE")

mkdir -p img
"${KD[@]}" parse -z "$KEYMAP" -o img/keymap.yaml

# Extract layer names dynamically from the parsed YAML
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

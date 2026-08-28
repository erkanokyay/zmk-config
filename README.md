# Sofle Choc Pro ZMK Configuration

This repository contains the ZMK firmware configuration for the Sofle Choc Pro keyboard.

## Features

- Custom keymap for Sofle Choc Pro.
- Support for ZMK Studio.
- Rotary encoder support for volume control and track navigation.
- RGB underglow support.
- Keymap image generation script.

## Directory Structure

- `boards/arm/sofle_choc_pro/`: Hardware and board definition files.
- `config/sofle_choc_pro.keymap`: Keymap configuration file.
- `config/sofle_choc_pro.conf`: Keyboard hardware and feature configuration file.
- `build.yaml`: GitHub Actions build matrix file.
- `draw_keymap.sh`: Script to generate keymap images.
- `img/`: Generated keymap images.

## How to Build the Firmware

GitHub Actions automatically builds the firmware when you push changes to this repository.

1. Push your changes to GitHub.
2. Open the **Actions** tab in your GitHub repository.
3. Select the latest workflow run.
4. Download the `firmware.zip` file from the **Artifacts** section.
5. Extract the archive to find the `.uf2` firmware files:
   - `sofle_choc_pro_left-settings_reset-zmk.uf2`
   - `sofle_choc_pro_left-zmk.uf2`
   - `sofle_choc_pro_right-settings_reset-zmk.uf2`
   - `sofle_choc_pro_right-zmk.uf2`

## How to Flash the Firmware

1. Connect the left half of the keyboard to your computer with a USB cable.
2. Put the half into bootloader mode:
   - Press the reset button on the board two times quickly, or
   - Press the `BOOT` key on the keyboard.
3. A USB drive named `NICENANO` will appear on your computer.
4. Copy the file `sofle_choc_pro_left-zmk.uf2` to the `NICENANO` drive.
5. The keyboard disconnects and reboots automatically when the flash process is complete.
6. Repeat these steps for the right half with `sofle_choc_pro_right-zmk.uf2`.

## How to Generate Keymap Images

You can generate graphical layout images locally with the drawing script.

### Prerequisites

Install these tools:
- `uv` (or `uvx`)
- `rsvg-convert` (from the `librsvg` package)
- `python3` with `pyyaml`

### Run the Script

Run the following command in the root directory:

```bash
./draw_keymap.sh
```

The script creates image files in the `img/` directory:
- `img/keymap.png`: Overview of all layers.
- `img/keymap-<layer>.png`: Individual layer diagrams.

## Keymap Layers

![Keymap Overview](img/keymap.png)

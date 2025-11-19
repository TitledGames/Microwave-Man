#!/bin/bash

# 1. Install dependencies for Godot Linux binary
sudo apt-get update && sudo apt-get install -y libfontconfig1 unzip wget

# 2. Download Godot 4 (Linux x86_64)
# Replace this URL with the specific version you need from https://godotengine.org/download/archive/
GODOT_URL="https://github.com/godotengine/godot/releases/download/4.5.1-stable/Godot_v4.5.1-stable_linux.x86_64.zip"
wget -O godot.zip "$GODOT_URL"

# 3. Unzip and move to /usr/local/bin
unzip godot.zip
sudo mv Godot_v* /usr/local/bin/godot
sudo chmod +x /usr/local/bin/godot

# 4. Clean up
rm godot.zip

echo "Godot installed! Version:"
godot --version

# 1. Create the directory Godot expects (Note: '4.5.1.stable' matches your error)
mkdir -p ~/.local/share/godot/export_templates/4.5.1.stable

# 2. Download the export templates
# (We use the official GitHub release naming convention)
wget -O templates.tpz https://github.com/godotengine/godot/releases/download/4.5.1-stable/Godot_v4.5.1-stable_export_templates.tpz

# 3. Unzip them (The .tpz file is just a zip file)
unzip templates.tpz

# 4. Move the files to the correct location
# The zip extracts to a folder named 'templates'. We move its contents.
mv templates/* ~/.local/share/godot/export_templates/4.5.1.stable/

# 5. Clean up
rm -rf templates templates.tpz

# 6. (Optional Fix) Handle "nothreads" error
# Some Godot versions/presets look for 'web_nothreads_debug.zip' specifically.
# If it's missing, we copy the standard debug template to satisfy the builder.
cd ~/.local/share/godot/export_templates/4.5.1.stable/
if [ ! -f web_nothreads_debug.zip ]; then
    echo "web_nothreads_debug.zip not found, creating fallback copy..."
    cp web_debug.zip web_nothreads_debug.zip
    cp web_release.zip web_nothreads_release.zip
fi

echo "Templates installed successfully."
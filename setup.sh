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
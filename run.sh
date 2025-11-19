#!/bin/sh

# Create a build directory
mkdir -p build/web

# Export the project
# "Web" must match the name of your export preset
godot --headless --export-release "Web" build/web/index.html

python3 serve.py
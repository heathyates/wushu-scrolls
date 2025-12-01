#!/bin/bash
set -e

# Create folder
cd $HOME
mkdir -p ~/tabby && cd ~/tabby

# Download Tabby release (GPU CUDA 12.3 example)
wget https://github.com/TabbyML/tabby/releases/download/v0.31.2/tabby_x86_64-manylinux_2_28-cuda123.tar.gz

# Extract
mkdir -p "$HOME/tabby_binaries"
tar -xzf tabby_x86_64-manylinux_2_28-cuda123.tar.gz --strip-components=1 -C "$HOME/tabby_binaries"

# Make executables runnable
cd "$HOME/tabby_binaries"
chmod +x llama-server

# Confirm installation
./tabby --version
echo "Tabby installed successfully."
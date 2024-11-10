#!/bin/bash

# Check for sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo privileges."
  exit 1
fi

# Function to display progress
function display_progress {
  echo -ne "$1...\r"
}

# Update and install necessary packages
display_progress "Updating and installing necessary packages"
apt-get update -qq
apt-get install -y ndiswrapper-utils-1.9 wget unzip >/dev/null
echo "Updating and installing necessary packages... Done."

# Create temporary directory for downloading driver files
TEMP_DIR="/tmp/wifi_drivers"
echo "Creating temporary directory: $TEMP_DIR"
mkdir -p $TEMP_DIR
cd $TEMP_DIR

# GitHub repository URL
REPO_URL="https://github.com/Nevergiveup11837/mt7902driverforlinux/raw/main"

# List of files to download
FILES=(
  "mtkihvx.dll"
  "mtkwl1.dat"
  "mtkwl1_2.dat"
  "mtkwl2.dat"
  "mtkwl2_2.dat"
  "mtkwl2_2s.dat"
  "mtkwl2s.dat"
  "mtkwl3.dat"
  "mtkwl3_2.dat"
  "mtkwl4.dat"
  "mtkwl6ex.cat"
  "mtkwl6ex.inf"
  "mtkwl6ex.sys"
  "WIFI_MT7902_patch_mcu_1_1_hdr.bin"
  "WIFI_MT7922_patch_mcu_1_1_hdr.bin"
  "WIFI_RAM_CODE_MT7902_1.bin"
  "WIFI_RAM_CODE_MT7922_1.bin"
)

# Download driver files from GitHub
echo "Downloading driver files from GitHub..."
for FILE in "${FILES[@]}"; do
  display_progress "Downloading $FILE"
  wget -q "$REPO_URL/$FILE"
  if [ $? -ne 0 ]; then
    echo "Failed to download $FILE. Exiting."
    exit 1
  fi
done
echo "Downloading driver files from GitHub... Done."

# Install driver using NDISWrapper
display_progress "Installing driver using NDISWrapper"
ndiswrapper -i mtkwl6ex.inf >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Failed to install driver with NDISWrapper. Exiting."
  exit 1
fi
echo "Installing driver using NDISWrapper... Done."

# Verify driver installation
display_progress "Verifying driver installation"
ndiswrapper -l
echo "Verifying driver installation... Done."

# Load NDISWrapper module
display_progress "Loading NDISWrapper module"
modprobe ndiswrapper
echo "Loading NDISWrapper module... Done."

# Copy firmware files to the system firmware directory
FIRMWARE_DIR="/lib/firmware"
display_progress "Copying firmware files to $FIRMWARE_DIR"
cp WIFI_MT7902_patch_mcu_1_1_hdr.bin $FIRMWARE_DIR/
cp WIFI_MT7922_patch_mcu_1_1_hdr.bin $FIRMWARE_DIR/
cp WIFI_RAM_CODE_MT7902_1.bin $FIRMWARE_DIR/
cp WIFI_RAM_CODE_MT7922_1.bin $FIRMWARE_DIR/
echo "Copying firmware files to $FIRMWARE_DIR... Done."

# Add NDISWrapper to module startup
display_progress "Adding NDISWrapper to module startup"
ndiswrapper -m >/dev/null 2>&1
update-initramfs -u >/dev/null 2>&1
echo "Adding NDISWrapper to module startup... Done."

# Clean up temporary directory
display_progress "Cleaning up temporary directory"
cd ~
rm -rf $TEMP_DIR
echo "Cleaning up temporary directory... Done."

echo "Driver installation complete. Please reboot your computer to finalize the configuration."

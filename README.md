
# MT7902 Driver for Linux
A newbie-friendly, temporary solution that encourages all contributions for long-term and stable use for MT7902 driver on Linux
This repository provides the necessary files and script to install the MT7902 Wi-Fi driver on a Linux system using NDISWrapper.

## Contents

- `install_wifi_driver.sh`: Shell script to automate the installation of the MT7902 driver on Linux.
- Driver files:
  - `mtkihvx.dll`
  - `mtkwl1.dat`
  - `mtkwl1_2.dat`
  - `mtkwl2.dat`
  - `mtkwl2_2.dat`
  - `mtkwl2_2s.dat`
  - `mtkwl2s.dat`
  - `mtkwl3.dat`
  - `mtkwl3_2.dat`
  - `mtkwl4.dat`
  - `mtkwl6ex.cat`
  - `mtkwl6ex.inf`
  - `mtkwl6ex.sys`
  - `WIFI_MT7902_patch_mcu_1_1_hdr.bin`
  - `WIFI_MT7922_patch_mcu_1_1_hdr.bin`
  - `WIFI_RAM_CODE_MT7902_1.bin`
  - `WIFI_RAM_CODE_MT7922_1.bin`

## Prerequisites

- A Linux system with sudo privileges.
- Internet connection to download necessary packages and driver files.

## Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Nevergiveup11837/mt7902driverforlinux.git
   cd mt7902driverforlinux
   
NOTES: You should use chmod +x install_wifi_driver.sh and sudo ./install_wifi_driver.sh to run the sh file corectly.
After install you will need to reboot your system to apply changes




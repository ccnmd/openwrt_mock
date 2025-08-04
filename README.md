OpenWRT Python Image Builder (for BeagleBone Black)

This project builds a fully customized OpenWRT firmware image for the BeagleBone Black, with Python 3.11 and a custom package (check_python) embedded into the final image — no need to install anything via SSH.
Features

    Based on OpenWRT v23.05.3
    Target: arm_cortex-a8_vfpv3 (BeagleBone Black)
    Custom package: check_python
    Dockerized build process
    Outputs firmware image (.img.gz) ready to flash

How to Use
1. Clone this repo

git clone https://github.com/ccnmd/openwrt_mock.git
git checkout feature/python_version_check

2. Build the Docker image
make docker-image

3. Build OpenWRT image

make create

4. Flash to SD card

Extract and flash using Raspberry Pi Imager or dd:

gzip -d openwrt-omap-generic-ti_am335x-bone-black-ext4-sdcard.img.gz 
sudo dd if=openwrt-omap-generic-ti_am335x-bone-black-ext4-sdcard.img of=/dev/sda bs=4M status=progress conv=fsync

Replace /dev/sdX with your actual SD card device.
Verify on BBB

After booting the device:

python3 --version

check_python



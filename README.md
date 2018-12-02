# Docker AOSP kernel builder [![Docker Build Status](https://img.shields.io/docker/build/study/docker-aosp-kernel-builder.svg)](https://hub.docker.com/r/study/docker-aosp-kernel-builder/)
Docker image to build an AOSP kernel

## Example
### Linux
```
# Checkout kernel source and switch to `android-msm-marlin-3.18-pie-r2` branch (Google Pixel XL - marlin)
$ git clone --single-branch --branch android-msm-marlin-3.18-pie-r2 --depth 1 https://android.googlesource.com/kernel/msm

# Build AOSP kernel for Google Pixel XL
$ cd msm
$ docker run --rm --volume $(pwd):/workdir study/docker-aosp-kernel-builder /bin/bash -c "make marlin_defconfig && make -j8"

# Flash your kernel with fastboot
$ adb reboot bootloader 
$ fastboot flash kernel arch/arm64/boot/Image.lz4-dtb
```

### OSX
```
# AOSP kernel can only be built under [case-sensitive file system](https://source.android.com/setup/build/initializing#setting-up-a-mac-os-x-build-environment), so we need to create case-sensitive file system image
$ hdiutil create -type SPARSE -volname "AOSP kernel" -fs 'Case-sensitive Journaled HFS+' -size 8g aosp_kernel.dmg

# Mount the image to `/Volumes/aosp_kernel_workspace`
$ hdiutil attach aosp_kernel.dmg.sparseimage -mountpoint /Volumes/aosp_kernel_workspace
$ cd /Volumes/aosp_kernel_workspace

# Checkout kernel source and switch to `android-msm-marlin-3.18-pie-r2` branch (Google Pixel XL - marlin)
$ git clone --single-branch --branch android-msm-marlin-3.18-pie-r2 --depth 1 https://android.googlesource.com/kernel/msm

# Build AOSP kernel for Google Pixel XL
$ cd msm
$ docker run --rm --volume $(pwd):/workdir study/docker-aosp-kernel-builder /bin/bash -c "make marlin_defconfig && make -j8"

# Flash your kernel with fastboot
$ adb reboot bootloader 
$ fastboot flash kernel arch/arm64/boot/Image.lz4-dtb

# Umount the image
$ cd ~
$ hdiutil detach /Volumes/aosp_kernel_workspace
```
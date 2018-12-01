# Docker AOSP kernel builder [![Docker Build Status](https://img.shields.io/docker/build/phstudy/docker-aosp-kernel-builder.svg)](https://hub.docker.com/r/study/docker-aosp-kernel-builder/)
Docker image to build an AOSP kernel

## Example
```
# Checkout kernel source and switch to `android-msm-marlin-3.18-pie-r2` branch (Google Pixel XL - marlin)
$ git clone --single-branch --branch android-msm-marlin-3.18-pie-r2 --depth 1 https://android.googlesource.com/kernel/msm

# Build AOSP kernel for Google Pixel XL
$ cd msm
$ docker run --rm --volume $(pwd):/workdir docker-aosp-kernel-builder /bin/bash -c "make marlin_defconfig && make -j8"

# Flash your kernel with fastboot
$ adb reboot bootloader 
$ fastboot flash kernel arch/arm64/boot/Image.lz4-dtb
```

## Caveat
AOSP kernel only can be built under case-sensitive file system. It means some OS such as OSX which will fail to build, because [OSX default installation](https://source.android.com/setup/build/initializing#setting-up-a-mac-os-x-build-environment) is case-insensitive file system.
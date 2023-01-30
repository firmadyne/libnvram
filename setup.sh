#!/bin/sh
set -eux

# valid: arm, mipsel, mipseb
ARCH=$1

SHORT_ARCH=mips
ABI=
TARGETS=vmlinux

if [ "$ARCH" = "arm" ]; then
TARGETS="vmlinux zImage" # only for arm
ABI=eabi # only for arm
SHORT_ARCH=$ARCH
fi

# Firmadyne cross compilers from https://zenodo.org/record/4922202
# works for kernel 4.10
CROSS_CC=/cross/${ARCH}-linux-musl${ABI}/bin/${ARCH}-linux-musl${ABI}-gcc


make clean
CC=$CROSS_CC make  libnvram.so
mv libnvram.so libnvram.so.$ARCH

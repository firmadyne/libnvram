#!/bin/bash
set -eux

# Host is mapped at /app

rm -rf /app/out
mkdir /app/out

SCRATCH=$(mktemp -d)/libnvram
mkdir $SCRATCH

CC=arm-linux-musleabi-gcc make libnvram.so -C /app
mv libnvram.so $SCRATCH/libnvram.so.arm
make clean

CC=mipsel-linux-musl-gcc make libnvram.so -C /app
mv libnvram.so $SCRATCH/libnvram.so.mipsel
make clean

CC=mipseb-linux-musl-gcc make libnvram.so -C /app
mv libnvram.so $SCRATCH/libnvram.so.mipseb
make clean

tar -czvf /app/libnvram-latest.tar.gz -C $(dirname $SCRATCH) libnvram
rm -rf /app/out
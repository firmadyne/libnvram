#!/bin/bash

set -eux

rm -f *.so.*
./setup.sh arm
./setup.sh mipsel
./setup.sh mipseb

rm -rf utils   || true
mkdir utils
mv *.so.* utils

mv utils/libnvram.so.arm utils/libnvram.so.armel

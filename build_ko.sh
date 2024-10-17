#!/bin/bash

#KMODULE=6.1.0-rpi7-rpi-2712
#KMODULE=6.1.0-rpi7-rpi-v8
#KMODULE=6.6.31+rpt-rpi-2712
#KMODULE=6.6.31+rpt-rpi-v8
#KMODULE=6.6.51+rpt-rpi-2712
KMODULE=6.6.51+rpt-rpi-v8

if [ ! -d /lib/modules/$KMODULE/build ]; then
  echo "Directory not found for $KMODULE"
  exit 1
fi

set -x
make KERNEL_MODULE=$KMODULE clean && \
make KERNEL_MODULE=$KMODULE KMACHINE=armv7l modules && \
cp unamehack.ko unamehack_$KMODULE.ko

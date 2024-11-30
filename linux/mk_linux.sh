#!/bin/bash

SCRIPT_DIR=$(dirname `readlink -f "$0"`)
cd "${SCRIPT_DIR}"

VERSION="6.6.63"
CONFIG="linux-${VERSION}.config"

if [ ! -f linux-${VERSION}.tar.gz ] ; then
	wget http://www.kernel.org/pub/linux/kernel/v6.x/linux-${VERSION}.tar.gz
fi
#
#
tar -jxf linux-${VERSION}.tar.gz

if [ -f "${CONFIG}" ] ; then
	cp "${CONFIG}"  linux-${VERSION}/.config
else
	cp linux.config  linux-${VERSION}/.config
fi
#
cd  linux-${VERSION}
make oldconfig
make

#
cd "${SCRIPT_DIR}"
cp linux-${VERSION}/arch/x86/boot/bzImage ../vmlinuz

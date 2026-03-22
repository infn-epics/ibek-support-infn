#!/bin/sh
##########################################################################
# install script for Bergoz BCM-RF-E support module
##########################################################################

# ARGUMENTS:
#   $1 VERSION — git tag / branch to install
VERSION=${1}
NAME=turbo-bergoz-bcm
FOLDER=$(dirname $(readlink -f $0))

# log output and abort on failure
set -xe

# clone the repo and patch configure/RELEASE paths
ibek support git-clone ${NAME} ${VERSION} --org https://github.com/infn-epics/
ibek support register ${NAME}

# no custom library — all deps (asyn, stream, calc) are already in the base image.
# declare them so they are linked into the IOC that uses this support.
ibek support add-libs asyn stream calc
ibek support add-dbds asyn.dbd stream.dbd drvAsynIPPort.dbd drvAsynSerialPort.dbd calcSupport.dbd

# global config settings (CROSS_COMPILER_TARGET_ARCHS, etc.)
${FOLDER}/../_global/install.sh ${NAME}

# compile (produces the db/ installation directory under $(TURBO_BERGOZ_BCM))
ibek support compile ${NAME}

# expose *.ibek.support.yaml and generated assets outside the container
ibek support generate-links ${FOLDER}

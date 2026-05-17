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

# The native bcmAsynMon driver manages its own TCP socket.
# No StreamDevice or drvAsynIPPort/SerialPort needed.
ibek support add-libs asyn calc bcmAsynMonSupport
ibek support add-dbds asyn.dbd bcm-rf-ioc.dbd calcSupport.dbd

# global config settings (CROSS_COMPILER_TARGET_ARCHS, etc.)
${FOLDER}/../_global/install.sh ${NAME}

# compile (produces the db/ installation directory under $(TURBO_BERGOZ_BCM))
ibek support compile ${NAME}

# expose *.ibek.support.yaml and generated assets outside the container
ibek support generate-links ${FOLDER}

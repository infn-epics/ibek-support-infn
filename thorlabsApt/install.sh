#!/bin/bash
# Install script for Thorlabs APT motor support library
VERSION=${1}
NAME=thorlabs-apt-motor
FOLDER=$(dirname $(readlink -f $0))
set -xe
ibek support git-clone ${NAME} ${VERSION} --org https://github.com/infn-epics/
ibek support register ${NAME}
ibek support add-libs thorlabsSupport motor asyn
ibek support add-dbds devThorLabsApt.dbd motorRecord.dbd motorSupport.dbd
${FOLDER}/../_global/install.sh ${NAME}
ibek support compile ${NAME}
ibek support generate-links ${FOLDER}

#!/bin/sh
##########################################################################
##### install script for midivac module ##################################
##########################################################################

VERSION=${1}
NAME=midivac
FOLDER=$(dirname $(readlink -f $0))

set -xe

ibek support git-clone ${NAME} ${VERSION} --org https://github.com/infn-epics/
ibek support register ${NAME}

ibek support add-libs asyn stream
ibek support add-dbds asyn.dbd drvAsynIPPort.dbd stream.dbd

${FOLDER}/../_global/install.sh ${NAME}

ibek support compile ${NAME}
ibek support generate-links ${FOLDER}

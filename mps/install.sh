#!/bin/bash

# install script for mps (SSRIP Machine Protection System) support module

THIS_DIR=$(dirname $(readlink -f $0))
source ${THIS_DIR}/../_global/install.sh

# copy template files
cp ${THIS_DIR}/*.template ${EPICS_DB_INCLUDE_PATH}/

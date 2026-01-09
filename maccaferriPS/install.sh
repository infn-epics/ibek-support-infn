#!/bin/bash
# Maccaferri Power Supply Support Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"

echo "Installing Maccaferri Power Supply support files..."

# Create support directory structure
mkdir -p "${SUPPORT_DIR:-./support}/maccaferriPS"
mkdir -p "${SUPPORT_DIR:-./support}/maccaferriPS/db"
mkdir -p "${SUPPORT_DIR:-./support}/maccaferriPS/opi"

# Copy database templates
if [ -d "${REPO_DIR}/maccaferriPS/templatedmodbusApp/Db" ]; then
    cp "${REPO_DIR}/maccaferriPS/templatedmodbusApp/Db"/*.template \
       "${SUPPORT_DIR:-./support}/maccaferriPS/db/" || true
    echo "✓ Copied database templates"
fi

# Copy OPI files
if [ -d "${REPO_DIR}/maccaferriPS/opi" ]; then
    cp "${REPO_DIR}/maccaferriPS/opi"/*.bob \
       "${SUPPORT_DIR:-./support}/maccaferriPS/opi/" || true
    echo "✓ Copied OPI files"
fi

# Copy startup script
if [ -f "${REPO_DIR}/maccaferriPS/iocBoot/modbusiocSample/ioc-modbus-device.cmd" ]; then
    cp "${REPO_DIR}/maccaferriPS/iocBoot/modbusiocSample/ioc-modbus-device.cmd" \
       "${SUPPORT_DIR:-./support}/maccaferriPS/"
    chmod +x "${SUPPORT_DIR:-./support}/maccaferriPS/ioc-modbus-device.cmd"
    echo "✓ Copied startup script"
fi

# Copy README
if [ -f "${REPO_DIR}/maccaferriPS/templatedmodbusApp/README.maccaferriPS.md" ]; then
    cp "${REPO_DIR}/maccaferriPS/templatedmodbusApp/README.maccaferriPS.md" \
       "${SUPPORT_DIR:-./support}/maccaferriPS/README.md"
    echo "✓ Copied README"
fi

echo "Maccaferri Power Supply support installation complete!"

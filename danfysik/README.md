# Danfysik SYS8X00 Power Supply Support

This module provides EPICS support for Danfysik SYS8X00 series power supplies using StreamDevice protocol.

## Features

- TCP/IP communication via Ethernet
- StreamDevice-based protocol handling
- UNIMAG interface for bipolar current control
- SNL sequencer for automatic polarity switching

## Entities

### tcp
Configures the TCP/IP connection to the power supply.

### ps
Loads the main power supply database with current/voltage control.

### unimag
Loads the UNIMAG database for bipolar operation.

### sequencer
Starts the SNL program for UNIMAG control.

## Usage

See the template in `ibek-templates/templates/ps/danfysik/danfysik.yaml.j2` for example configuration.
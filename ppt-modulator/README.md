# PPT Modulator Support

This module provides EPICS support for the PPT (Pulse Power Technology) Modulator system using StreamDevice over TCP/IP.

## Overview

The PPT Modulator is a high-voltage pulse power system that controls various subsystems including:
- Thyratron heaters
- Klystron heaters
- Focus power supply
- Premagnetisation
- High Voltage Power Supply (HVPS)
- PFN charging system

## Features

- Binary TCP/IP communication on port 2000
- StreamDevice-based protocol for reading 86 bytes of status data
- Real-time monitoring of:
  - Voltages and currents for multiple subsystems
  - Temperature sensors
  - Water flow and temperatures
  - Timer values
  - Interlock and status messages
- Control interface for ON/OFF commands and HVPS voltage setpoint

## Repository

https://github.com/infn-epics/ppt-modulator

## Dependencies

- EPICS Base
- asyn
- StreamDevice

## Usage

```yaml
entities:
  - type: ppt.PptModulatorController
    name: PPT1
    P: "PPT:"
    R: "MOD1:"
    IP: "192.168.197.111"
    TCPPORT: 2000
```

## Database Templates

- `ppt.template`: Read-only monitoring records (voltages, currents, temperatures, status)
- `ppt_control.template`: Control records (ON/OFF commands, HVPS setpoint)

## Protocol File

The StreamDevice protocol file `ppt.proto` is located in the `db` directory and defines:
- Binary data reading (86 bytes total)
- Individual parameter extraction using offset positioning
- Support for all documented monitoring values

## Notes

- The device sends 86 bytes of binary data
- All multi-byte values are transmitted in little-endian format (LSB first)
- Control commands support auto-reset after 500ms for pulse mode operation
- Individual subsystems can be controlled independently

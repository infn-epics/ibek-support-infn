# EEI Power Supply Modbus Support

IBEK support module for EEI Power Supply via Modbus TCP/IP communication.

## Overview

This module provides EPICS support for EEI Power Supplies using Modbus protocol. It supports communication via TCP/IP and provides comprehensive control and monitoring capabilities.

## Features

- Full Modbus TCP/IP communication support
- Command control (Standby, Power On, Global Off, Reset, Start Ramp)
- Current and voltage setpoints and readbacks
- Polarity control with safety interlocks
- Comprehensive fault monitoring and reporting
- Status word monitoring
- Temperature and voltage monitoring for AC/DC and DC/DC converters

## Dependencies

- asyn
- modbus

## Usage

See `psEEI.ibek.support.yaml` for entity model definitions and parameters.

## Database Records

The module provides the following main record groups:

- Command Words (Control operations)
- Status Words (Operational status)
- Current and Voltage setpoints/readbacks
- Fault monitoring (PLC, DC/DC, AC/DC converters)
- Temperature monitoring
- Polarity control with interlocks

## Configuration Example

```yaml
- type: psEEI.tcp
  name: EEI_TCP
  P: "EEI:"
  IP: "192.168.190.153"
  TCPPORT: 502

- type: psEEI.ps
  tcpctrl: EEI_TCP
  R: "PS01"
  SLAVE_ID: 1
  MAX_CURR: 330000
```

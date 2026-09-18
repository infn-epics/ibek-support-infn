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

Each device is a single `EEI.ps` entity - it declares its own TCP/IP connection directly, there is no
separate connection entity:

```yaml
- type: EEI.ps
  P: "EEI"
  R: "PS01"
  IP: "192.168.190.153"
  TCPPORT: 502
  SLAVE_ID: 1
  MAX_CURR: 330000
  MIN_CURR: -330000
```

### Sequencer tolerances and timeout

The UNIMAG sequencer (`unimagEEIControl`) does not wait for an exact zero or an exact setpoint - neither is ever
reached on real hardware (sensor noise, regulator dead-band). Three optional parameters tune it per unit; each is
also a live PV (`<P>:<R>:ZERO_TOLERANCE`, `SET_TOLERANCE`, `SET_TIMEOUT_S`) that can be changed at runtime:

| parameter | default | meaning |
|---|---|---|
| `ZERO_TOLERANCE` | 2.0 A | \|readback\| at or below this counts as zero before standby / polarity change |
| `SET_TOLERANCE` | 1.0 A | readback within this of the request counts as reached (0 disables the check) |
| `SET_TIMEOUT_S` | 30.0 s | timeout of every wait (zero, standby, polarity, power on, setpoint) |

A step that times out raises `ST_NOT_REACHED` (`STATE_RB` = 7, MAJOR); a setpoint not reached within
`SET_TOLERANCE` raises `SP_NOT_REACHED` (`STATE_RB` = 6, MINOR). Both clear on the next setpoint or `CMD_RESET`.

```yaml
- type: EEI.ps
  P: "EEI"
  R: "QUAD01"
  IP: "192.168.190.152"
  ZERO_TOLERANCE: 1.5
  SET_TOLERANCE: 0.5
  SET_TIMEOUT_S: 45
```

With the `psEEI` template of `ibek-templates`, set `zero_tolerance` / `set_tolerance` / `set_timeout_s` once
at IOC level and/or per device (the device value wins); when omitted, the defaults above apply.

For a pulsed-dipole/H-bridge unit (no polarity contactors - see `psEEI.ibek.support.yaml` for the full
parameter list and defaults):

```yaml
- type: EEI.ps
  P: "EEI"
  R: "DHPTB102"
  IP: "192.168.190.157"
  MAX_CURR: 100000
  MIN_CURR: -100000
  POLARITY_VIA_SIGN: 1
```

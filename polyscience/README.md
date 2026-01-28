# Polyscience Chiller Support

IBEK support module for Polyscience Programmable Chillers.

## Overview

This module provides EPICS support for Polyscience programmable temperature controllers using StreamDevice over an ethernet-to-serial converter connection.

## Connection

- **Protocol**: Serial ASCII over TCP (transparent ethernet-to-serial converter)
- **Baud Rate**: 9600 baud, 8 data bits, 1 stop bit, no parity (set on converter)
- **Terminator**: CR (carriage return only)
- **Default Port**: 4001

## Features

- Temperature monitoring (internal and external probes)
- Temperature setpoint control
- Unit on/off control
- Pump speed control (0-70%)
- Alarm monitoring and configuration
- Remote probe selection (internal/external)
- Local lockout control
- chillerSmc OPI compatibility layer (via unicool-poly.db)

## Usage Example

```yaml
entities:
  - type: polyscience.CreateCtrl
    name: "POLYSCI_PORT"
    IP: "192.168.1.100"
    TCPPORT: 4001
    P: "TEST:CHL:01"
```

## PV Naming

### Primary PVs (polyscience.db)

| PV Suffix | Description |
|-----------|-------------|
| INT_TEMP_RB | Internal temperature readback |
| EXT_TEMP_RB | External temperature readback |
| TEMP_SETPT_RB | Temperature setpoint readback |
| TEMP_SETPT_SP | Temperature setpoint |
| CTR_SP | Unit on/off control |
| OPERATION_STATUS_RB | Operation status (Running/Standby) |
| ALARM_STATUS_RB | Alarm status |
| HIGH_ALARM_SP/RB | High temperature alarm |
| LOW_ALARM_SP/RB | Low temperature alarm |
| PUMP_SPEED_SP/RB | Pump speed (0-70%) |
| REMOTE_PROBE_SP/RB | Remote probe selection |
| LOCKOUT_SP/RB | Local lockout control |
| FIRMWARE_RB | Firmware revision |
| TEMP_UNITS_RB | Temperature units (C/F) |

### Compatibility Aliases (unicool-poly.db)

| Alias | Maps To | Description |
|-------|---------|-------------|
| TEMP_RB | INT_TEMP_RB | Temperature readback |
| TEMP_SP | TEMP_SETPT_SP | Temperature setpoint |
| STATE_SP | CTR_SP | State control |
| STATE_RB | (calculated) | Decoded state (0=OFF,1=RUN,2=WARNING,3=ALARM) |
| STATUS_RB | (calculated) | Combined status register |
| STATUS:RUN | | Run status bit |
| STATUS:ALARM | | Alarm status bit |
| STATUS:WARN | | Warning status bit |
| CTR_RB | | Control mode readback |
| CONN_STATUS | | Connection status |

## Compatibility

The module includes a compatibility database (polyscience-compat.db) that provides aliases and computed records compatible with SMC HECR OPIs, allowing reuse of existing operator interfaces.

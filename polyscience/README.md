# Polyscience Chiller Support

IBEK support module for Polyscience Programmable Chillers.

## Overview

This module provides EPICS support for Polyscience programmable temperature controllers using StreamDevice over an ethernet-to-serial converter connection.

## Connection

- **Protocol**: Serial ASCII over TCP (transparent ethernet-to-serial converter)
- **Terminator**: CR (carriage return)
- **Default Port**: 4001

## Features

- Temperature monitoring (internal and external probes)
- Temperature setpoint control
- Unit on/off control
- Pump control
- Fault status monitoring
- Program control (steps, loops)
- SMC HECR OPI compatibility layer

## Usage Example

```yaml
entities:
  - type: polyscience.CreateCtrl
    name: "POLYSCI_PORT"
    IP: "192.168.1.100"
    TCPPORT: 4001
    P: "TEST:CHL:01"
```

## PV Naming (SMC Compatible)

| PV Suffix | Description |
|-----------|-------------|
| INT_TEMP_RB | Internal temperature readback |
| EXT_TEMP_RB | External temperature readback |
| TEMP_SETPT_RB | Temperature setpoint readback |
| TEMP_SETPT_SP | Temperature setpoint |
| CTR_SP | Unit on/off control |
| CTR_RB | Unit status readback |
| PUMP_SP | Pump control |
| PUMP_RB | Pump status |
| FAULT_RB | Fault status code |
| STATE_RB | Decoded state (0=OFF,1=RUN,2=WARNING,3=ALARM) |

## Compatibility

The module includes a compatibility database (polyscience-compat.db) that provides aliases and computed records compatible with SMC HECR OPIs, allowing reuse of existing operator interfaces.

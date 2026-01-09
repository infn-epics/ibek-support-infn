# Maccaferri Power Supply IOC Support

Modbus RTU support for Maccaferri high-voltage power supplies.

## Features

- **Serial RTU Communication**: Native Modbus RTU over serial port
- **Signed Current Control**: UNIMAG interface with automatic polarity switching
- **Fast Readbacks**: Current and voltage updates at 25 Hz (40ms poll)
- **Complete State Management**: Power On/Standby/Fault states with automatic sequencing
- **Comprehensive Fault Monitoring**: 10+ fault indicators with automatic interlock
- **SNL State Machine**: Automatic polarity switching with safe ramp-to-zero protocol

## Quick Start

### Typical Configuration

```yaml
iocs:
  - name: "maccaferri-ps"
    devtype: maccaferri
    devgroup: mag
    iocprefix: "MY:PREFIX"
    template: "modbus"
    opi: "maccaferri/maccaferriPS.bob"
    
    iocparam:
      - name: "server"
        value: "192.168.1.100"    # Modbus TCP gateway
      - name: "port"
        value: 502               # Modbus TCP port
    
    devices:
      - name: "PS01"
        id: 1
        imax: 330
        vmax: 100
```

## Register Mapping

- **Command Area**: 0x0000-0x0001 (Holding Registers)
  - 0x0000: Commands (9 bits for Standby, On, Off, Reset, StartRamp, ModeDC, ModePulsed, Polarity±)
  - 0x0001: Current Setpoint (int16, A)

- **Status Area**: 0x0020-0x0022 (Input Registers)
  - 0x0020: Faults (bits 0-6: UV, OC, OT, Comm, Input, Relay, Other)
  - 0x0021: Additional Faults & States (bits 0-5: Breaker, Ground, Inhibit, Standby, PowerOn, Remote)
  - 0x0022: Mode/Polarity Status (bits 0-5: DC Mode, Pulsed Mode, Polarity±, Ramp Active, Remote)

- **Fast Readback**: 0x0023-0x0026 (polled 40ms → 25 Hz)
  - 0x0023: Current (int16, A)
  - 0x0024: Output Current (int16, A)
  - 0x0025: Output Voltage (int16, V)
  - 0x0026: Ground Current (int16, A)

## OPI Interfaces

### maccaferriPS.bob - Main Control Panel
Complete power supply control with status, current setpoint, and all commands

### maccaferriPS_unimag.bob - UNIMAG Interface
Simplified signed current control with automatic polarity switching

### maccaferriPS_debug.bob - Debug Panel
Raw PV access for troubleshooting and detailed monitoring

## State Machine (maccaferriControl.st)

Automatic sequencing for safe operation:

1. **Current Setpoint Change**: User sets positive/negative current
2. **Polarity Check**: SNL program determines if polarity change is needed
3. **Safe Ramp**: If polarity change needed:
   - Ramp current to zero
   - Go to Standby
   - Open contactors (safe interlock)
   - Change polarity
4. **Power On**: Power supply returned to On state
5. **Current Ramp**: New current value applied via ramp command

Timeout protection: 30-second timeout with automatic abort on fault detection

## Serial Configuration

Default: 19200 baud, 8N1, no flow control

Configurable via asynSetOption in startup script

## Performance

- Current/Voltage Update Rate: ≥25 Hz (40ms poll cycle)
- Fault Response: ≤1 second (1000ms slow poll)
- Command Execution: ~100ms
- Safe state transitions: 1-3 seconds (with polarity change)

## Requirements

- EPICS base 3.15+
- asyn 4.36+
- modbus support module
- seq/snl (for state machine)

## References

- Maccaferri Power Supply Specification: CS-20051109.1
- Modbus Documentation: https://en.wikipedia.org/wiki/Modbus

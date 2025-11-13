# Scandinova RF Modulator IBEK Support

This IBEK support module provides configuration for Scandinova RF Modulators using Modbus TCP/IP communication.

## Description

The `scandinova-rfmod` module implements the split-debug configuration that creates individual Modbus ports for each register group, providing better isolation and debugging capabilities.

## Features

- **Split Debug Configuration**: Each register or register group has its own Modbus port for better isolation
- **Configurable Polling Rates**: Different polling rates for different register types
  - Standard registers: 4000ms (default)
  - Watchdog: 2000ms read / 800ms write
  - Slow registers (RF, Flow): 5000ms
  - Test registers: 10000ms
- **Comprehensive Register Coverage**:
  - Core status and control registers
  - CCPS voltages (3 channels)
  - Filament power supply
  - Ion pump
  - Solenoid power supply
  - Pulse measurements
  - Tank oil monitoring
  - Temperature sensors (4 channels)
  - RF measurements (Forward, Reflected, VSWR, Power Length)
  - Flow meters (7 channels)
  - CCPS interlocks (3 channels)

## Usage

### Basic Configuration

```yaml
- type: scandinova-rfmod.RFModulator
  name: "1"
  P: "MODHEL01"
  IP: "pwelimod001.int.eli-np.ro"
  SLAVE_ADDR: 1
  TCPPORT: 502
```

### Multiple Modulators

```yaml
- type: scandinova-rfmod.RFModulator
  name: "1"
  P: "MODHEL01"
  IP: "modulator1.example.com"

- type: scandinova-rfmod.RFModulator
  name: "2"
  P: "MODHEL02"
  IP: "modulator2.example.com"
```

### Custom Polling Rates

```yaml
- type: scandinova-rfmod.RFModulator
  name: "1"
  P: "MODHEL01"
  IP: "modulator.example.com"
  POLLING: 2000                    # Fast polling for critical registers
  SLOW_REGISTER_POLLING: 10000     # Very slow polling for RF/Flow
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | id | - | Modulator identifier (e.g., "1", "2", "3") |
| `P` | str | - | PV prefix (e.g., "MODHEL01") |
| `SLAVE_ADDR` | int | 1 | Modbus slave address |
| `IP` | str | - | IP address or hostname |
| `TCPPORT` | int | 502 | Modbus TCP port |
| `POLLING` | int | 4000 | Standard polling rate (ms) |
| `WD_POLLING` | int | 2000 | Watchdog read polling (ms) |
| `WD_WRITE_POLLING` | int | 800 | Watchdog write polling (ms) |
| `SLOW_REGISTER_POLLING` | int | 5000 | Slow register polling (ms) |
| `TEST_POLLING` | int | 10000 | Test probe polling (ms) |

## Generated PVs

The module loads `scandinova-rfmod-split-debug.db` which creates PVs with the structure:

- `$(P):TCP:PROT_ID` - TCP Protocol ID
- `$(P):TCP:PROT_REV` - TCP Protocol Revision
- `$(P):STATE_RB` - State readback
- `$(P):STATUS_RB` - Status readback
- `$(P):CCPS1:VOLT_RB` - CCPS1 voltage readback
- `$(P):CCPS2:VOLT_RB` - CCPS2 voltage readback
- `$(P):CCPS3:VOLT_RB` - CCPS3 voltage readback
- `$(P):FILPS:CURR_RB` - Filament PS current
- `$(P):PLS:CURR_RB` - Pulse current
- `$(P):PLS:VOLT_RB` - Pulse voltage
- `$(P):PLS:WDTH_RB` - Pulse width
- `$(P):RF:FWD_RB` - RF forward power
- `$(P):RF:REFL_RB` - RF reflected power
- `$(P):FLOW:CCPS1_RB` - CCPS1 flow
- And many more...

## Dependencies

- EPICS Base
- asyn
- modbus
- scandinova-rfmod support module

## Performance Notes

This split-debug configuration creates approximately 50+ Modbus ports per device for maximum debugging capability. For production use with multiple devices, consider the optimized configuration which groups registers and reduces port count by ~67%.

## Related Modules

- `scandinova-rfmod` - Main EPICS support module
- Original repository: https://github.com/infn-epics/scandinova-rfmod

# OCEM E642 Power Supply Driver - Configuration Parameters

This document describes all configurable parameters for the OCEM E642 serial power supply driver.

## Overview

The OCEM E642 driver consists of two entity types:
- **E642Group**: Controller entity for initialization of the ASYN port and driver configuration
- **E642**: Slave entity for each individual power supply channel

---

## E642Group (Controller) Parameters

These parameters configure the driver-level settings for the entire chain of power supplies.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `P` | str | *required* | Device prefix (e.g., `BTF:MAG:OCEME642`) |
| `NAME` | str | *required* | Logical name of this E642 controller |
| `IP` | str | *required* | Controller IP address |
| `TCPPORT` | int | `502` | Controller TCP port |
| `SLAVELIST` | str | *required* | Comma-separated list of slave IDs (e.g., `"0,2,1,3"`) |
| `INIT_TIMEOUT_S` | float | `5.0` | Timeout for each PS init before retry (seconds) |
| `INIT_MAX_RETRIES` | int | `3` | Max retries before marking PS failed |
| `IDLE_POLL_S` | float | `1.0` | Polling interval when no commands active (seconds) |
| `ACTIVE_POLL_S` | float | `0.1` | Polling interval when commands are being processed (seconds) |
| `ACTIVE_TIMEOUT_S` | float | `5.0` | How long to stay in active mode after last command (seconds) |
| `DEBUG_LEVEL` | int | `0` | Debug level: 0=Errors only, 1=Basic info, 2=Protocol details, 3=Full trace |

### Debug Levels

| Level | Description |
|-------|-------------|
| 0 | Errors only (default) |
| 1 | Basic info (commands sent, polling cycles) |
| 2 | Protocol details (ENQ/ACK/NAK, raw bytes) |
| 3 | Full trace (every function call, all data) |

---

## E642 (Slave) Parameters

These parameters configure each individual power supply channel.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `P` | str | *required* | Device prefix |
| `R` | str | *required* | Geographical/logical name of the slave (e.g., `QUATM001`) |
| `NAME` | str | *required* | Must match the controller NAME for ASYN port |
| `ADDR` | int | *required* | Slave ID |
| `IMAX` | float | `280` | Max current for this slave (Amperes) |
| `VMAX` | float | `40` | Max voltage for this slave (Volts) |
| `SET_TOLERANCE` | float | `1.0` | Tolerance for current setpoint verification (Amperes) |
| `ZERO_TOLERANCE` | float | `1.0` | Tolerance for zero current check (Amperes) |
| `SET_TIMEOUT_S` | float | `10.0` | Timeout for reaching setpoint (seconds) |
| `INIT_TIMEOUT_S` | float | `60.0` | Timeout before retrying PRG initialization (seconds) |
| `CURRENT_THRESHOLD` | float | `-1` | Current threshold for unsolicited messages (A). -1 = auto (5% of IMAX) |
| `VOLTAGE_THRESHOLD` | float | `-1` | Voltage threshold for unsolicited messages (V). -1 = auto (5% of VMAX) |
| `POLL_STATE` | int | `0` | Enable periodic SL (state) polling: 0=disabled, 1=enabled |
| `POLL_STATE_INTERVAL` | float | `1.0` | SL polling interval (seconds) |
| `POLL_ANALOG` | int | `0` | Enable periodic SA (analog) polling: 0=disabled, 1=enabled |
| `POLL_ANALOG_INTERVAL` | float | `1.0` | SA polling interval (seconds) |

### Unsolicited Message Thresholds

The `CURRENT_THRESHOLD` and `VOLTAGE_THRESHOLD` parameters control when the power supply sends spontaneous COR/TEN messages:
- Set to `-1` (default) for automatic threshold calculation (5% of IMAX/VMAX)
- Set to a specific value to override the automatic calculation

### Polling Configuration

The `POLL_STATE` and `POLL_ANALOG` parameters enable periodic queries:
- When enabled and the FIFO is empty, the driver periodically sends SL/SA commands
- This ensures state is kept up-to-date even without explicit commands

---

## Template Configuration (YAML)

When using the ocem.yaml.j2 template, the following global parameters can be set:

### Controller-level (applied to E642Group)
```yaml
server: "192.168.192.40"      # Controller IP
port: 4014                     # Controller TCP port (default: 502)
init_timeout_s: 20             # PS init timeout (default: 5.0)
init_max_retries: 3            # Max init retries (default: 3)
idle_poll_s: 0.3               # Idle polling rate (default: 1.0)
active_poll_s: 0.1             # Active polling rate (default: 0.1)
active_timeout_s: 10           # Active timeout (default: 5.0)
debug_level: 0                 # Debug level (default: 0)
```

### Slave-level defaults (applied to all E642 slaves)
```yaml
set_tolerance: 1.9             # Setpoint tolerance (default: 1.0)
zero_tolerance: 1.8            # Zero tolerance (default: 1.0)
set_timeout_s: 60              # Setpoint timeout (default: 10)
init_timeout_s: 60             # Init timeout (default: 60)
current_threshold: 100         # Current threshold, -1=auto (default: -1)
voltage_threshold: 25          # Voltage threshold, -1=auto (default: -1)
poll_state: 1                  # Enable SL polling (default: 0)
poll_state_interval: 1.0       # SL poll interval (default: 1.0)
poll_analog: 1                 # Enable SA polling (default: 0)
poll_analog_interval: 1.0      # SA poll interval (default: 1.0)
```

### Per-device overrides
Each device in the `devices` list can override any slave-level parameter:
```yaml
devices:
  - name: QUATM001
    id: 2
    imax: 100
    vmax: 25
    set_tolerance: 2.0         # Override global default
    current_threshold: 50      # Override global default
```

---

## Example Configuration

```yaml
devtype: E642
iocprefix: "BTF:MAG:OCEME642"
name: "QUATM05"
server: "192.168.192.40"
port: 4014

# Controller settings
init_timeout_s: 20
init_max_retries: 3
idle_poll_s: 0.3
active_poll_s: 0.1
active_timeout_s: 10
debug_level: 0

# Global slave defaults
set_tolerance: 1.9
zero_tolerance: 1.8
set_timeout_s: 60
current_threshold: 100
voltage_threshold: 25
poll_state: 1
poll_analog: 1

devices:
  - name: QUATB102
    id: 0
    imax: 100
    vmax: 25
  - name: QUATM001
    id: 2
    imax: 100
    vmax: 25
  - name: QUATM004
    id: 1
    imax: 100
    vmax: 25
  - name: QUATB101
    id: 3
    imax: 100
    vmax: 25
```

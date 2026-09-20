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

## UNIMAG watchdog parameters

The UNIMAG overlay of `ps` (when `unimag_enable` is true) exposes the tuning of its state and setpoint watchdogs. Each
parameter is also a live PV of the unit (`<prefix>SET_TOLERANCE`, `ZERO_TOLERANCE`, `SET_TIMEOUT_S`):

| parameter | default | meaning |
|-----------|---------|---------|
| `ZERO_TOLERANCE` | 0.5 A | a zero setpoint counts as reached within this |
| `SET_TOLERANCE` | 1.0 A | readback within this of `CURRENT_SP` counts as reached (0 disables the check) |
| `SET_TIMEOUT_S` | 30 s | timeout of the setpoint / state watchdogs, restarted on progress |

`STATE_RB` shows `SP_NOT_REACHED` (6, MINOR) when the setpoint is not reached in time and
`ST_NOT_REACHED` (7, MAJOR) when the commanded state is not; `CONN_FAULT` (5, MAJOR) reports
communication errors. With the `ibek-templates` `danfysik` template set `zero_tolerance`, `set_tolerance`
and `set_timeout_s` at IOC level and/or per device (the device value wins).

`AT_SETPOINT` compares `CURR_DIFF` with `SET_TOLERANCE`; `RAMPING` (8) and `POL_CHANGE` (9) are
device specific `STATE_RB` states.

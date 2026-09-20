# OCEM Modbus Power Supply Support

IBEK support module for the OCEM power supplies (`modbusps`, one channel, and `modbusps4chan`, four channels)
of the `OCEMPowerSupply` IOC support.


## UNIMAG watchdog parameters

The UNIMAG overlay of `modbusps` and `modbusps4chan` exposes the tuning of its state and setpoint watchdogs. Each
parameter is also a live PV of the unit (`<prefix>SET_TOLERANCE`, `ZERO_TOLERANCE`, `SET_TIMEOUT_S`):

| parameter | default | meaning |
|-----------|---------|---------|
| `ZERO_TOLERANCE` | 0.5 A | a zero setpoint counts as reached within this |
| `SET_TOLERANCE` | 1.0 A | readback within this of `CURRENT_SP` counts as reached (0 disables the check) |
| `SET_TIMEOUT_S` | 30 s | timeout of the setpoint / state watchdogs, restarted on progress |

`STATE_RB` shows `SP_NOT_REACHED` (6, MINOR) when the setpoint is not reached in time and
`ST_NOT_REACHED` (7, MAJOR) when the commanded state is not; `CONN_FAULT` (5, MAJOR) reports
communication errors. With the `ibek-templates` `ocem` template set `zero_tolerance`, `set_tolerance`
and `set_timeout_s` at IOC level and/or per device (the device value wins).

On `modbusps4chan` the parameters are per crate and apply to each of its four ways (`WAYA`..`WAYD`).

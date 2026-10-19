# Caenels Easy driver Support 

## UNIMAG watchdog parameters

The UNIMAG overlay of `ps` (serial) and `ps_iocast` exposes the tuning of its state and setpoint watchdogs. Each
parameter is also a live PV of the unit (`<prefix>SET_TOLERANCE`, `ZERO_TOLERANCE`, `SET_TIMEOUT_S`):

| parameter | default | meaning |
|-----------|---------|---------|
| `ZERO_TOLERANCE` | 0.5 A | a zero setpoint counts as reached within this |
| `SET_TOLERANCE` | 1.0 A | readback within this of `CURRENT_SP` counts as reached (0 disables the check) |
| `SET_TIMEOUT_S` | 30 s | timeout of the setpoint / state watchdogs, restarted on progress |

`STATE_RB` shows `SP_NOT_REACHED` (6, MINOR) when the setpoint is not reached in time and
`ST_NOT_REACHED` (7, MAJOR) when the commanded state is not; `CONN_FAULT` (5, MAJOR) reports
communication errors. With the `ibek-templates` `hazemeyer` template set `zero_tolerance`, `set_tolerance`
and `set_timeout_s` at IOC level and/or per device (the device value wins).

## CHV TL cubicles on the CITBus (`cit`, `cit_channel`)

A CHV TL cubicle is a Modbus RTU slave (its Main Monitoring Unit) with 8 channels
(MAU0..MAU7). The gateway is a `serial` entity; each cubicle is a `cit` entity
(`ID` = slave address, PVs `<P>:CIT<ID>:...`) and each channel a `cit_channel`
(`CHANNEL` 0..7, PVs `<P>:<R>:...`, UNIMAG interface, aliased as
`<P>:CIT<ID>:CH<CHANNEL+1>:...` for the cubicle OPI `hzacc.bob`). The databases come from
[hazemeyer-citbus](https://github.com/infn-epics/hazemeyer-citbus), installed
by `../hazemeyer-citbus`; see its README for the Modbus map and the PVs.

| parameter | entity | default | meaning |
|-----------|--------|---------|---------|
| `MEAS_POLL`, `STS_POLL` | `cit` | 500, 1000 ms | polling of measurements / detailed faults |
| `PULSE` | `cit` | 0.5 s | command pulse width |
| `ON_DLY` | `cit` | 3 s | Standby to Power On delay of the cubicle |
| `IMAX`, `VMAX` | `cit_channel` | 10 A, 20 V | full scale current / voltage |
| `RAWMAX_SP`, `RAWMAX_RB` | `cit_channel` | 2048, 8192 | raw setting / readback at full scale (signed) |
| `ZERO_TOLERANCE`, `SET_TOLERANCE`, `SET_TIMEOUT_S` | `cit_channel` | 0.05 A, 0.1 A, 30 s | UNIMAG watchdogs |

With the `ibek-templates` `hazemeyer` template use `devtype: haz-cit`: `devices[].id`
is the cubicle slave address, `devices[].channel` the channel; the cubicles are
named after their slave address (`CIT<id>`).

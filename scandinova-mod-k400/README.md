# Scandinova Modulator K400 IBEK Support

This folder provides IBEK support for the `scandinova-mod-k400` EPICS support module.

## What it configures

- Modbus TCP/IP connection to one K400 modulator
- Loading of the original startup command file:
  - `iocBoot/rr-c-ioc-sparc-001/sparc-scandinova-k400.cmd`
- Loading of the K400 records database:
  - `rr-c-ioc-sparc-001App/Db/sparc-scandinova-k400.db`

## Entity

- `scandinova-mod-k400.RFModulator`

## Main Parameters

- `name`: unique modulator identifier used in the asyn port name
- `P`: PV prefix
- `SLAVE_ADDR`: Modbus slave address (default: `1`)
- `IP`: Modulator IP or hostname
- `TCPPORT`: Modbus TCP port (default: `502`)

## Dependencies

- asyn
- modbus

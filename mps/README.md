# MPS - SSRIP Machine Protection System

EPICS device support for the SSRIP Machine Protection System used at ELI-NP.

## Overview

The MPS communicates via Modbus TCP through a MOXA serial-to-ethernet gateway.  
It uses the `asyn` and `modbus` EPICS modules.

## Dependencies

- EPICS Base R7.0.7+
- asyn R4-44-2+
- modbus R3-2+

## Parameters

| Parameter   | Description                          | Default |
|-------------|--------------------------------------|---------|
| NAME        | Instance name / Modbus port prefix   | -       |
| IP          | MOXA gateway IP address              | -       |
| TCPPORT     | Modbus TCP port                      | 502     |
| SLAVE_ADDR  | Modbus slave address                 | 1       |
| P           | PV prefix (e.g. RUF-MPS-A-001)      | -       |
| POLLING     | Polling interval (ms)                | 100     |

## PV Records

- `$(P):BOOTUP` - Boot timestamp
- `$(P):BENCHMARK` - FSM benchmark (us)
- `$(P):TEMP` - Device temperature (°C)
- `$(P):WATCHDOG` - FSM watchdog
- `$(P):SLEEP` - Sleep mode status
- `$(P):RESET` - Reset FSM command
- `$(P):ACK_SP` - Acknowledge command
- `$(P):ENABLE` - MPS enable status
- `$(P):BYPASS:VAC_COR_SP` - Bypass VAC corridor
- `$(P):BYPASS:VAC_RUF_SP` - Bypass VAC roof
- `$(P):BYPASS:LLRF_SP` - Bypass LLRF
- `$(P):BYPASS:MOD_SP` - Bypass modulator
- `$(P):ILK:VAC_COR` - VAC corridor interlock word
- `$(P):ILK:VAC_RUF` - VAC roof interlock word
- `$(P):ILK:LLRF` - LLRF interlock word
- `$(P):ILK:MOD` - Modulator interlock word

## Authors

- Giulia Latini <Giulia.Latini@lnf.infn.it>

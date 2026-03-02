# Menlo Support Module

EPICS support for Menlo Systems laser synchronization devices.

## Supported Devices

- **LAC1550** — Laser Amplifier Controller (oscillator + amplifier + auxiliary stages, diode monitoring)
- **LFC** — Laser Frequency Comb (frequency counter with diode/TEC control)
- **SYNCRO** — RF Synchronization unit (PID lock, motors, TECs)
- **SYNCRO-FLS** — FLS variant with 8-channel ADC module
- **SYNCRO-THETA** — Theta variant with 7 TEC channels (temperature-only)

## Protocol

All devices communicate via the Menlo HRT binary protocol over TCP/IP.
The `asynInterposeMenlo` interpose layer handles CRC-16 framing and SOT/EOT escaping.

## Dependencies

- EPICS base
- asyn
- StreamDevice
- asynInterposeMenlo (from ibek-support-infn)

# Agilent TwisTorr 305 Support

IBEK support definition for the Agilent TwisTorr 305 IOC:
https://baltig.infn.it/lnf-da-control/agilent-twistorr-305.git

## Entities

- `agilent.twistorr305.controller`
  - Configures one asyn TCP/IP port.
  - Sets `STREAM_PROTOCOL_PATH` to the module protocol location.
- `agilent.twistorr305.pump`
  - Loads one `agilent-twistorr-305.db` instance.
  - Uses `device`, `addr`, and `port` macros.

## Typical Defaults

- `TCPPORT`: `4005`
- `addr`: `0x80`

# keysight34465A

ibek support for the Keysight 34465A Truevolt DMM
(repo [infn-epics/multimeter-keysight](https://github.com/infn-epics/multimeter-keysight)).

StreamDevice over the raw SCPI socket (TCP 5025). Entity `keysight34465A.dmm`
loads `keysight34465A.db`: all 12 measurement functions, range/NPLC/autozero/null,
trigger and sample count, `READ?` statistics, SCPI error latch, and a user
conversion `CONV_* = reading * CONV_FACTOR + CONV_OFFSET` in unit `CONV_EGU`.

```yaml
- type: keysight34465A.dmm
  name: DMM01
  P: ACC:DIAG:DMM
  R: DMM01
  IP: 192.168.190.18
  CONV_FACTOR: 1000.0   # e.g. Q[pC] = V * 1 nF * 1e12
  CONV_EGU: pC
  BOOT_STATE: STATE_1.sta   # optional: restored at every IOC boot
```

ibek template: `ibek-templates/templates/daq/keysight34465A`.
OPI: `epik8s-opi/keysight/keysight34465A.bob` (macros `P`, `R`).

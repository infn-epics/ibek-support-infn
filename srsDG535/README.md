# SRS DG535 Support

IBEK support for the Stanford Research Systems DG535 Digital Delay / Pulse
Generator on GPIB, built from [gbip-ddg](https://github.com/infn-epics/gbip-ddg).

| entity | description |
|--------|-------------|
| `niEnetPort` | asyn GPIB port on an NI GPIB-ENET/1000, native NI network protocol (no NI software): `NAME`, `IP`, `BOARD_PAD` (0), `PRIORITY` (0) |
| `DG535` | DG535 StreamDevice database on an asyn GPIB port: `PORT`, `P`, `R`, `ADDR` (15), `SCAN` (2 second), `SCAN_CFG` (10 second) |

PVs are `P:R:<name>`: `{A,B,C,D}_DELAY_SP/RB` (s) and `{A,B,C,D}_REF_SP/RB`,
trigger `TRIG_*` / `BURST_*`, outputs `{T0,A,B,AB,C,D,CD}_{MODE,AMPL,OFFSET,LOAD}`
and `{T0,A,B,C,D}_POL`, status `STATUS_RB` / `ERROR_RB`.

Setpoints read the instrument at iocInit and are never written at boot. Each
query is two network round trips through the ENET: over a WAN use a slower
`SCAN` and `SCAN_CFG: Passive`.

```yaml
entities:
  - type: srsDG535.niEnetPort
    NAME: GPIB0
    IP: 192.168.191.35
  - type: srsDG535.DG535
    PORT: GPIB0
    P: TEST
    R: DDG535
    ADDR: 14
```

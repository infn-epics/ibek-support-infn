# standa-motor

ibek support for Standa 8SMC1-USBhF stepper motor controllers
([infn-epics/standa-motor](https://github.com/infn-epics/standa-motor)).

Each 8SMC1 is a separate USB device, and it speaks vendor control transfers, not
serial, so ser2net cannot be used. Plug the controllers into a small host
(e.g. a Raspberry Pi) and run `python/usmc_server.py` there. The IOC reaches
them through that TCP bridge, so it can run anywhere.

## Entity models

| Entity | Description |
|---|---|
| `standa.controller` | Bridge connection plus the controller; `serials` lists one controller per axis |
| `standa.axis` | Motor record plus `:Temperature`, `:Voltage`, `:Serial`, `:Connected` |

## Example

```yaml
entities:
  - type: standa.controller
    controllerName: STANDA1
    P: "TEST:MOT:STANDA"
    IP: 192.168.104.89
    serials: "6183 5912"

  - type: standa.axis
    controller: STANDA1
    M: ":M1"
    ADDR: 0
    DESC: "Standa SN 6183"
```

Units: the controller counts 1/8 full steps. With the default `MRES: 0.125` the
EGU is full steps, and VELO ranges from 2 to 625 steps/s. The controller has no
home input, so homing is not supported. CNEN switches motor power.

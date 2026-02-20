# Thorlabs APT Motor Support

ibek support module for the Thorlabs APT motor controller driver.

Supports:
- DC servo motors: TDC001, KDC101, BBD103, BBD203, etc.
- Stepper motors: TST001, KST101, BSC103, BSC203, LTS, etc.
- Single-channel USB controllers and multi-channel bay controllers
- Local USB serial (`/dev/ttyUSBx`) and remote TCP via ser2net (`host:port`)

## Entity models

| Entity | Description |
|---|---|
| `thorlabsApt.AptController` | Creates a Thorlabs APT controller instance |
| `thorlabsApt.motorAxis` | Creates a motor axis with standard EPICS motor record |
| `thorlabsApt.AptSetVelParams` | (Optional) Sets raw APT velocity parameters per axis |

## Example ibek IOC YAML

```yaml
entities:
  - type: thorlabsApt.AptController
    controllerName: APT-DC1
    P: "Motor:"
    devicePath: "/dev/ttyUSB0"
    motorType: dc
    numAxes: 1

  - type: thorlabsApt.motorAxis
    controller: APT-DC1
    M: "DC1"
    ADDR: 0
    DESC: "KDC101 DC Servo"
    EGU: mm
    VELO: 2.3
    MRES: 0.000028939405515
    DHLM: 25.0
    DLLM: -0.1
```

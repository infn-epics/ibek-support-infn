# Technosoft-Asyn IBEK Support

EPICS support for Technosoft intelligent drives using the TML_lib high-level library and EPICS motor record interface.

## Overview

This driver provides EPICS motor record support for Technosoft intelligent motor drives (e.g., iPOS, iSERVO) using:
- **TML_lib**: Technosoft Motion Language library
- **asynMotorController**: Standard EPICS motor record interface
- **RS-232/RS-485/CAN/XPORT**: Communication via serial or Ethernet

## Source Repository

https://github.com/infn-epics/technosoft-asyn

## Key Features

- Standard EPICS motor record interface
- Supports multiple axes on a single communication channel
- Configurable setup files (.t.zip from EasyMotion Studio)
- Homing via limit switches (LSN/LSP)
- Polling control (moving vs. idle)

## Configuration

### TmlControllerConfig
```
TmlControllerConfig(portName, devicePath, numAxes, hostId, baudRate, movingPoll, idlePoll)
```

### TmlAxisConfig
```
TmlAxisConfig(portName, axisNo, axisId, setupFile, homingSwitch)
```

## Related Modules

- **motor**: EPICS motor record support
- **asyn**: EPICS asyn driver framework
- **TML_lib**: Technosoft Motion Language library

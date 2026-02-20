# Technosoft-Asyn IBEK Support - Summary

## Files Created

### 1. IBEK Support Module
**Location:** `/Users/michelottilabs/progetti/infn-epics-ioc/ibek-support-infn/technosoft-asyn/`

**Files:**
- `technosoft-asyn.ibek.support.yaml` - Entity definitions for TML controller and axes
- `technosoft-asyn.install.yml` - Installation configuration
- `install.sh` - Build script
- `README.md` - Documentation

**Entity Models:**
- `technosoftAsyn.TmlController` - Creates a TML motion controller
  - Supports RS-232/RS-485/XPORT communication
  - Configurable polling rates
  - Multiple axes per controller

- `technosoftAsyn.TmlAxis` - Creates individual motor axes
  - Standard EPICS motor record interface
  - Configurable setup files (.t.zip from EasyMotion)
  - Homing via LSN/LSP limit switches
  - Full motor record parameters (VELO, ACCL, MRES, limits, etc.)

### 2. Motor Template Update
**Location:** `/Users/michelottilabs/progetti/infn-epics-ioc/ibek-templates/templates/motor/motor.yaml.j2`

**Added devtype:** `technosoft-asyn`

**Configuration Parameters:**
- `server` - Device path or IP address
- `port` - TCP port (for XPORT connections)
- `motor.hostId` - RS-232 host ID (default: 255)
- `motor.baudRate` - Serial baud rate (default: 9600)
- `motor.movingPollPeriod` - Poll rate while moving (default: 0.1s)
- `motor.idlePollPeriod` - Poll rate while idle (default: 1.0s)
- `motor.setupFile` - Default TML setup file path
- `motor.homingSwitch` - Default homing switch (LSN/LSP)
- Standard motor parameters: egu, velo, vbas, accl, mres, prec, dhlm, dllm, twv

**Per-Device Parameters:**
- `axisId` - TML drive address (1-255)
- `setupFile` - Axis-specific setup file (overrides default)
- `homingSwitch` - Axis-specific homing switch
- All standard motor record parameters can be overridden per-axis

### 3. Test Configuration
**Location:** `/Users/michelottilabs/progetti/infn-epics-ioc/ibek-templates/tests/motor-technosoft-asyn-test.yaml`

Example configuration showing:
- Serial device connection (`/dev/ttyUSB0`)
- IP connection format (commented)
- Two-axis configuration
- Per-axis parameter customization

## Usage Example

```yaml
devtype: technosoft-asyn
server: "/dev/ttyUSB0"  # or "192.168.1.100" for XPORT
# port: 4001  # Required for XPORT

motor:
  hostId: 255
  baudRate: 9600
  setupFile: "$(SUPPORT)/technosoft-asyn/tml_lib/config/default-setup.t.zip"
  homingSwitch: LSN
  egu: "mm"
  velo: 2.0
  mres: 0.001

devices:
  - name: "M1"
    axisId: 1
    desc: "Motor 1"
  - name: "M2"
    axisId: 2
    velo: 5.0  # Override default velocity
    homingSwitch: LSP  # Override homing switch
```

## Differences from NDS-based TML Support

The existing `motorTML` module uses NDS (Nominal Device Support), while this new
`technosoftAsyn` module uses:
- Standard EPICS motor record
- asynMotorController/asynMotorAxis framework
- Direct TML_lib integration
- Compatible with all EPICS motor tools and GUIs

## Installation Requirements

The install script assumes:
- Repository: https://github.com/infn-epics/technosoft-asyn
- Dependencies: motor, asyn, TML_lib
- DBDs: devTechnosoft.dbd, motorRecord.dbd, motorSupport.dbd
- Runtime libraries: libTML_lib.so, libtmlcomm.so

## Next Steps

1. Ensure the technosoft-asyn repository is available at the expected location
2. Update `technosoft-asyn/configure/RELEASE` if needed
3. Test with a real hardware configuration
4. Update the test YAML with actual setup file paths

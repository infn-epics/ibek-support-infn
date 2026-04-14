# Midivac IBEK support

This module exposes the Varian MidiVac ion pump controller as a single IBEK controller entity.

Provided entity:
- `midivac.controller`

Required IOC parameters:
- `server`
- `port`

The generated records include HV control, mode, protect current threshold, setpoints, firmware, and utility commands.

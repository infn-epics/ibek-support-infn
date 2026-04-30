# Danfysik Hall Probes Support

IBEK support definition for https://github.com/infn-epics/Danfysik_HallProbes.

## Entity

- `hallprobe`: configures one TCP/IP asyn port and loads `hallprobe.db`.

## Notes

- StreamDevice protocol path is set to `$(DANFYSIK_HALLPROBES)/db`.
- The runtime database uses the same macros as the original IOC startup:
  - `P` (prefix)
  - `R` (suffix)
  - `PORT` (asyn port)

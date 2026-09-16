# Known-good FORMKEYS dump. Fill from DEV, never from memory.
# MVP: empty / <PIN> means assert-skip (do not INSERT).
# A form that compiled with stripped keys is Ok=false (exit 4) once a real dump is present.

# P1-H1: empty until a human pastes a known-good DEV dump. Assert skips empty / <PIN>.
@{
    ZCLA_PARTLONGDESC  = @()
    ZCLA_PARTLONGDHIST = @()
    ZCLA_PARTLONGDREV  = @()
}

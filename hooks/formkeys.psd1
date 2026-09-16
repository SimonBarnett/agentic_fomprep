# Known-good FORMKEYS dump. Fill from DEV, never from memory.
# MVP: empty / <PIN> means assert-skip (do not INSERT).
# A form that compiled with stripped keys is Ok=false (exit 4) once a real dump is present.

@{
    ZCLA_PARTLONGDESC = @(
        @{
            Col     = 'PART'
            KeyType = '<PIN>'
            Notes   = 'example - replace from a known-good DEV dump'
        }
    )
    ZCLA_PARTLONGDHIST = @()
    ZCLA_PARTLONGDREV  = @()
}

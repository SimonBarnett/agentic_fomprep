# Empty named trigger stubs

## Symptom
FORMTRIG has a named custom trigger but FORMTRIGTEXT has zero lines.

## Detect
Join FORMTRIG to TRIGGERS; flag TRIGNAME like ZCLA_% with no FORMTRIGTEXT rows. Compare to a good instance before restore.

## Repair
Copy FORMTRIGTEXT + INCTRIG from the good instance; Named Form Prep (UPD=N + LASTPREPDATE advanced). Compare by TRIGNAME when TRIG ids differ across instances.

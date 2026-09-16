-- Read-only reconnaissance for CE Priority DEV Form Prep.
-- Run from tools/Invoke-Recon.ps1 on CE-PRIORITY-DEV1, Windows integrated.
-- Do not guess column types. Pin results into config/dev.psd1, then set PinComplete = $true.
-- Database list: system and the company DB used by web (often company/base).

-- 1. Session
SELECT DB_NAME() AS db, SUSER_SNAME() AS login, HOST_NAME() AS host, @@SERVERNAME AS server_name;

-- 2. Find prep / exec tables
SELECT s.name AS sch, t.name AS tbl
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE t.name LIKE '%PREP%' OR t.name LIKE '%EXEC%'
ORDER BY t.name;

-- 3. Candidate columns on EXECPREPLOCK (adjust once found)
-- SELECT c.name, ty.name, c.max_length
-- FROM sys.columns c
-- JOIN sys.types ty ON ty.user_type_id = c.user_type_id
-- WHERE c.object_id = OBJECT_ID('dbo.EXECPREPLOCK');

-- 4. Any table that has BOTH UPD and LASTPREPDATE (operator source of truth)
SELECT s.name AS sch, t.name AS tbl
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE EXISTS (
        SELECT 1 FROM sys.columns c WHERE c.object_id = t.object_id AND c.name = 'UPD'
      )
  AND EXISTS (
        SELECT 1 FROM sys.columns c WHERE c.object_id = t.object_id AND c.name = 'LASTPREPDATE'
      )
ORDER BY s.name, t.name;

-- 5. Resolve form names the way Priority does
-- Historical CE pattern: EXEC / TSEXEC with ENAME, EXEC (= numeric id)
-- SELECT TOP 20 *
-- FROM dbo.EXEC
-- WHERE ENAME LIKE 'ZCLA_PARTLONG%';

-- 6. FORMKEYS / FORMJOINS candidates (for post-hooks; do not INSERT until a human dump exists)
SELECT s.name AS sch, t.name AS tbl
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE t.name LIKE '%FORMKEY%' OR t.name LIKE '%FORMJOIN%' OR t.name LIKE '%FORMCLM%'
ORDER BY t.name;

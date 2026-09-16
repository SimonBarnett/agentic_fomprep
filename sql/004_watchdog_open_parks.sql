-- Optional Phase 2 watchdog: any park row older than 30 minutes is a Sev-1 risk.
-- ~1000 forms look prepared and are not until restore_ok is set.

SELECT
    run_id,
    COUNT(*)            AS open_rows,
    MIN(parked_at)      AS oldest_parked_at,
    DATEDIFF(MINUTE, MIN(parked_at), GETDATE()) AS age_minutes
FROM dbo.AGENT_FORMPREP_PARK
WHERE restored_at IS NULL
GROUP BY run_id
ORDER BY oldest_parked_at;

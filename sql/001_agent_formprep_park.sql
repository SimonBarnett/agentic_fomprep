-- Park table is the restore source of truth. Not a text file.
-- Run on the pinned DB (config/dev.psd1 SqlDatabase = system) after WP0 recon.
-- Side-car C:\Priority\tmp\agent-formprep\{runId}\parked_execs.txt is a dump only.
--
-- WP0 types: T$EXEC / LASTPREPDATE / PID are bigint. Do not use INT/DATETIME.
-- Install-OnDev.ps1 -ApplyParkTable drops an empty wrong-type table; it refuses
-- if any restored_at IS NULL rows exist.

IF OBJECT_ID('dbo.AGENT_FORMPREP_PARK') IS NULL
BEGIN
    CREATE TABLE dbo.AGENT_FORMPREP_PARK (
        run_id        UNIQUEIDENTIFIER NOT NULL,
        exec_id       BIGINT           NOT NULL,
        ename         NVARCHAR(64)     NULL,
        prev_upd      CHAR(1)          NOT NULL,
        prev_lastprep BIGINT           NULL,
        prev_computer NVARCHAR(128)    NULL,
        prev_pid      BIGINT           NULL,
        prev_lockexpiry BIGINT         NULL,
        parked_at     DATETIME         NOT NULL DEFAULT GETDATE(),
        restored_at   DATETIME         NULL,
        restore_ok    CHAR(1)          NULL,
        PRIMARY KEY (run_id, exec_id)
    );

    CREATE INDEX IX_AGENT_FORMPREP_PARK_OPEN
        ON dbo.AGENT_FORMPREP_PARK (restored_at)
        WHERE restored_at IS NULL;
END
GO

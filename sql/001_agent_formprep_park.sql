-- Park table is the restore source of truth. Not a text file.
-- Run on the pinned company DB (config/dev.psd1 SqlDatabase) after recon.
-- Side-car C:\Priority\tmp\agent-formprep\{runId}\parked_execs.txt is a dump only.

IF OBJECT_ID('dbo.AGENT_FORMPREP_PARK') IS NULL
BEGIN
    CREATE TABLE dbo.AGENT_FORMPREP_PARK (
        run_id        UNIQUEIDENTIFIER NOT NULL,
        exec_id       INT              NOT NULL,
        ename         NVARCHAR(64)     NULL,
        prev_upd      CHAR(1)          NOT NULL,
        prev_lastprep DATETIME         NULL,   -- change type after recon if LASTPREPDATE is not datetime
        prev_computer NVARCHAR(128)    NULL,
        prev_pid      INT              NULL,
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

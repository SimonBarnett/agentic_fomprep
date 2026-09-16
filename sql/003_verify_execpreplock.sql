-- Verify EXECPREPLOCK for named forms after Form Prep.
-- Success is UPD = 'N' AND LASTPREPDATE advanced vs the pre-park snapshot.
-- UI completion / CLI exit 0 is not a success signal.

-- Pinned on DEV1 WP0: system.dbo.EXECPREPLOCK join system.dbo.T$EXEC on T$EXEC.
-- SELECT E.[ENAME], L.[UPD], L.[LASTPREPDATE], L.[COMPUTERNAME], L.[PID]
-- FROM dbo.EXECPREPLOCK L
-- JOIN dbo.[T$EXEC] E ON E.[T$EXEC] = L.[T$EXEC]
-- WHERE E.[ENAME] LIKE 'ZCLA_PARTLONG%';

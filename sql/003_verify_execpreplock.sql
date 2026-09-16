-- Verify EXECPREPLOCK for named forms after Form Prep.
-- Success is UPD = 'N' AND LASTPREPDATE advanced vs the pre-park snapshot.
-- UI completion / CLI exit 0 is not a success signal.

-- SELECT E.[ENAME], L.[UPD], L.[LASTPREPDATE], L.[COMPUTERNAME], L.[PID]
-- FROM dbo.EXECPREPLOCK L
-- JOIN dbo.EXEC E ON E.[EXEC] = L.[EXEC]
-- WHERE E.[ENAME] LIKE 'ZCLA_PARTLONG%';

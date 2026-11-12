# No one could log in because the Priority app and Redis services had stopped

Issue type: nobody can log in to an on-premise or partner-hosted Priority.

Known: on 2026-09-16 08:43 BST support recorded that the system was down and no one could log in, because the Priority App service and the Priority Redis service were stopped. Support restarted them and the system was back up. Support asked the hosting provider why the services had stopped and whether there was a scheduled restart. On 2026-10-14 support closed the call as resolved. Server names are not stored. Why the services stopped is not recorded.

This is for on-premise or partner-hosted servers. For Priority cloud, raise it with the supplier instead.

## Steps

1. Confirm all users are affected, not one user.
2. On the application server, check the Priority services, including the App service and the Redis service.
3. If they are stopped, an authorised administrator starts them.
4. Confirm users can log in again.
5. Ask the hosting owner why they stopped (for example a scheduled restart or update) so it does not recur.

## Verification

Proven: after the two services were restarted the system was back up (SC262863, support-verified).

Not proven: why the services stopped.

## Stop

Stop if the services are running. Then check the web server, database and network before restarting anything else.

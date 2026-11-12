# No one could log in because the Priority app and Redis services had stopped

Issue type: nobody can log in to an on-premise or partner-hosted Priority.

Known: on 2026-09-16 08:43 BST support recorded that the system was down and no one could log in, because the Priority App service and the Priority Redis service were stopped. Support restarted them and the system was back up. Support asked the hosting provider why the services had stopped and whether there was a scheduled restart. On 2026-10-14 support closed the call as resolved. Server names are not stored. Why the services stopped is not recorded. Second example: SC262824, 2026-09-14 08:59 BST, another customer could not log in because the Priority App service and the Priority Redis service were not running; support restarted them and the issue was sorted. Third example: SC262608, 2026-08-28 07:49 BST, nobody could get past the login screen; the web services were not running because the database and web servers had rebooted at the same time overnight and the database was not up when the web services tried to connect. After restarting the services everyone could log in (confirmed by phone). Support suggested the server owner make the web server always reboot after the database server.

This is for on-premise or partner-hosted servers. For Priority cloud, raise it with the supplier instead.

## Steps

1. Confirm all users are affected, not one user.
2. On the application server, check the Priority services, including the App service and the Redis service.
3. If they are stopped, an authorised administrator starts them.
4. Confirm users can log in again.
5. Ask the hosting owner why they stopped (for example a scheduled restart or update) so it does not recur.

## Verification

Proven: after the two services were restarted the system was back up (SC262863, SC262824 and SC262608, support-verified).

Not proven: why the services stopped.

## Stop

Stop if the services are running. Then check the web server, database and network before restarting anything else.

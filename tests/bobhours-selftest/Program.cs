int hours = PriorityAgent.BobHours.RunOfflineSelfTest();
int lastUser = PriorityAgent.LastUser.RunFr384SelfTest();
return hours == 0 && lastUser == 0 ? 0 : 1;

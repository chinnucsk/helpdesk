-module(request, 
[Id,
 ClUserId,
 Status,
 DepartId,
 IdWorker,
 IdOrder,
 CreationTime,
 WorkerInTime,
 WorkerOutTime,
 CloseTime,
 ChangeTime,
 Note]
).
-compile(export_all).


-belongs_to(depart).
-belongs_to(cl_user).

-has({comments, many}).
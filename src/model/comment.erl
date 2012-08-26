-module(comment, 
[Id,
 RequestId,
 Note::string(),
 ClUserId,
 DepartId,
 CreationTime,
 ChangeTime]
).
-compile(export_all).

-belongs_to(request).
-belongs_to(cl_user).
%%-belongs_to(depart).

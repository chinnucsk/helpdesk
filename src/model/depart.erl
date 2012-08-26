-module(depart, 
[Id,
 Name::string(),
 Note::string(),
 CreationTime,
 ChangeTime]
).
-compile(export_all).

-has({cl_users, many}).
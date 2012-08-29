-module(helpdesk_request_controller, [Req, SessionID]).
-compile(export_all).

before_(_) ->
    user_lib:require_login(Req).

index('GET',[], Person) ->
    Requests = boss_db:find(request, []),
    Users = boss_db:find(cl_user,[]),
    Departs = boss_db:find(depart, []),
    {ok, [{departs, Departs},{requests, Requests},{ip, Req:peer_ip()},{count, boss_db:count(request)},{cl_user,Person},{users,Users}, {count_comments,boss_db:count(comment)}]}.

report01('GET',[], Person) ->
    Requests = boss_db:find(request, []),
    Users = boss_db:find(cl_user,[]),
    Departs = boss_db:find(depart, []),
    {ok, [{departs, Departs},{requests, Requests},{ip, Req:peer_ip()},{count, boss_db:count(request)},{cl_user,Person},{users,Users}, {count_comments,boss_db:count(comment)}]}.

create('GET', [], Person) ->
    Departs = boss_db:find(depart, []),
    {ok,[{departs, Departs}, {ip, Req:peer_ip()}, {cl_user, Person}]};
create('POST', [], Person) ->
    %%Id = "",
    ClUserId = Person:id(),
    DepartId = Req:post_param("depart_id"),
    Status = "New",
    IdWorker = "",
    IdOrder = Req:post_param("id_order"),
    CreationTime = erlang:localtime(),
    WorkerInTime = "",
    WorkerOutTime = "",
    CloseTime = "",
    ChangeTime = erlang:localtime(),
    Note = Req:post_param("note"),

    NewRequest = request:new(id, ClUserId, Status, DepartId, IdWorker, IdOrder, CreationTime, WorkerInTime, WorkerOutTime, CloseTime, ChangeTime, Note),

    case NewRequest:save() of
        {ok, SavedAddress} ->
           {redirect,[{action, "../main/user_request"}]};
        {error, Reason} ->
                Reason
    end.

edit('GET', [Id], Person) ->
    Request = boss_db:find(Id),
    Departs = boss_db:find(depart, []),
    {ok, [{departs, Departs}, {request, Request}, {ip, Req:peer_ip()}, {cl_user, Person}]};
edit('POST', [Id], Person) ->
    Request = boss_db:find(Id),
    ClUser = boss_db:find(Person),
    NewRequest = Request:set([{cl_user_id, Req:post_param("cl_user_id") },
                              {status, Req:post_param("status")},
                              {depart_id, Req:post_param("depart_id")},
                              {id_worker, Req:post_param("id_worker")},
                              {id_order, Req:post_param("id_order")},
                              {note, Req:post_param("note")},
                              %%{creation_time, Req:post_param("creation_time")},
                              %%{worker_in_time, Req:post_param("worker_in_time")},
                              %%{worker_out_time,  Req:post_param("worker_out_time")},
                              %%{close_time, Req:post_param("close_time")},
                              {change_time,erlang:localtime()}]),
    case NewRequest:save() of
        {ok, SavedAddress} ->
            {redirect,[{action, "index"}]};
        {error, Reason} ->
                Reason
    end.

set_worker('GET', [Id], Person) ->
    Request = boss_db:find(Id),
    Departs = boss_db:find(depart, []),
    {ok, [{departs, Departs}, {request, Request}, {ip, Req:peer_ip()}, {cl_user, Person}]};

set_worker('POST', [Id], Person) ->
    Request = boss_db:find(Id),
    ClUser = boss_db:find(Person),
    NewRequest = Request:set([
                              %%{cl_user_id, Req:post_param("cl_user_id") },
                              {status, "InWorks"},
                              %%{depart_id, Req:post_param("depart_id")},
                              {id_worker, Req:post_param("id_worker")},
                              %%{id_order, Req:post_param("id_order")},
                              %%{note, Req:post_param("note")},
                              %%{creation_time, Req:post_param("creation_time")},
                              {worker_in_time, erlang:localtime()},
                              %%{worker_out_time,  Req:post_param("worker_out_time")},
                              %%{close_time, Req:post_param("close_time")},
                              {change_time,erlang:localtime()}]),
    case NewRequest:save() of
        {ok, SavedAddress} ->
            {redirect,[{action, "../main/depart_request"}]};
        {error, Reason} ->
                Reason
    end.

set_close('GET', [Id], Person) ->
    Request = boss_db:find(Id),
    Departs = boss_db:find(depart, []),
    {ok, [
            {departs, Departs},
            {request, Request},
            {ip, Req:peer_ip()},
            {cl_user, Person}
         ]};
set_close('POST', [Id], Person) ->
    Request = boss_db:find(Id),
    ClUser = boss_db:find(Person),
    NewRequest = Request:set([
                              %%{cl_user_id, Req:post_param("cl_user_id") },
                              {status, "Close"},
                              %%{depart_id, Req:post_param("depart_id")},
                              %%{id_worker, Req:post_param("id_worker")},
                              %%{id_order, Req:post_param("id_order")},
                              %%{note, Req:post_param("note")},
                              %%{creation_time, Req:post_param("creation_time")},
                              %%{worker_in_time, erlang:localtime()},
                              %%{worker_out_time,  erlang:localtime()},
                              {close_time, erlang:localtime()},
                              {change_time,erlang:localtime()}]),
    case NewRequest:save() of
        {ok, SavedAddress} ->
            {redirect,[{action, "../main/user_request"}]};
        {error, Reason} ->
                Reason
    end.

set_complit('GET', [Id], Person) ->
    Request = boss_db:find(Id),
    Departs = boss_db:find(depart, []),
    {ok, [
            {departs, Departs},
            {request, Request},
            {ip, Req:peer_ip()},
            {cl_user, Person}
         ]};
set_complit('POST', [Id], Person) ->
    Request = boss_db:find(Id),
    ClUser = boss_db:find(Person),
    NewRequest = Request:set([
                              %%{cl_user_id, Req:post_param("cl_user_id") },
                              {status, "Complite"},
                              %%{depart_id, Req:post_param("depart_id")},
                              %%{id_worker, Req:post_param("id_worker")},
                              %%{id_order, Req:post_param("id_order")},
                              %%{note, Req:post_param("note")},
                              %%{creation_time, Req:post_param("creation_time")},
                              %%{worker_in_time, erlang:localtime()},
                              {worker_out_time,  erlang:localtime()},
                              %%{close_time, erlang:localtime()},
                              {change_time,erlang:localtime()}]),
    case NewRequest:save() of
        {ok, SavedAddress} ->
            {redirect,[{action, "../main/depart_request"}]};
        {error, Reason} ->
                Reason
    end.

show('GET', [Id], Person) ->
    Request = boss_db:find(Id),
    Users = boss_db:find(cl_user,[]),
    Departs= boss_db:find(depart, []),
    {ok, [{departs, Departs},{request, Request}, {ip, Req:peer_ip()}, {cl_user, Person}, {users, Users}]};
show('POST', [Id], Person) ->
    Request = boss_db:find(Id),
    Note = Req:post_param("comm_note"),
    NewComment = comment:new(id, Request:id(), Note, Person:id(), Person:depart_id(), erlang:now(),erlang:now()),
    case NewComment:save() of
        {ok, SavedAddress} ->
            {redirect,[{action, "show/"++Id}]};
        {error, Reason} ->
                Reason
    end.

comm('GET', []) ->
    {ok, [{count_comm, boss_db:count(comment,[])}]}.



delete('GET',[Id]) ->
    boss_db:delete(Id),
    {redirect,[{action, "index"}]}.

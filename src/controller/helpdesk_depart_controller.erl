-module(helpdesk_depart_controller, [Req, SessionID]).
-compile(export_all).

before_(_) ->
    user_lib:require_login(Req).

index('GET',[], Operator) ->
    Users = boss_db:find(cl_user,[]),
    Departs = boss_db:find(depart, []),
    {ok, [{index_depart, true},{users, Users},{departs, Departs},{ip, Req:peer_ip()},{count, boss_db:count(depart)},{cl_user,Operator}]}.

create('GET', [], Operator) -> {ok,[{ip, Req:peer_ip()},{cl_user, Operator}]};
create('POST', [], Operator) ->
    Name = Req:post_param("name"),
    Note = Req:post_param("note"),
    CreationTime = erlang:localtime(),
    ChangeTime = erlang:localtime(),

    NewDepart = depart:new(id, Name, Note, CreationTime, ChangeTime),

    case NewDepart:save() of
        {ok, SavedDepart} ->
           {redirect,[{action, "index"}]};
        {error, Reason} ->
                Reason
    end.


edit('GET', [Id], Operator) ->
    Departs = boss_db:find(Id),
    {ok, [{departs, Departs}, {ip, Req:peer_ip()}, {cl_user, Operator}]};
edit('POST', [Id], Operator) ->
    Departs = boss_db:find(Id),
    NewDeparts = Departs:set([{name, Req:post_param("name")},
                              {note, Req:post_param("note")},
                              %%{creation_time, Req:post_param("creation_time")},
                              {change_time, erlang:localtime()}]),
    case NewDeparts:save() of
        {ok, SavedDeparts} ->
            {redirect,[{action, "index"}]};
        {error, Reason} ->
                Reason
    end.

%% Просмотр заданий по данному отделу
request('GET', [Id], Operator) ->
    Request = boss_db:find(request, [{depart_id, Id}], [{order_by,creation_time},descending]),
    Depart = boss_db:find(Id),
    {ok, [{count_depart_request, boss_db:count(request,[{depart_id, Id}])},
        {count_depart_request_notclose, boss_db:count(request,[{depart_id, Id},{status,'not_equals',"Close"}])},
        {count_depart_request_new, boss_db:count(request,[{depart_id, Id},{status,"New"}])},
{requests, Request},{ip, Req:peer_ip()}, {cl_user, Operator}, {depart, Depart}]}.

show('GET', [Id], Operator) ->
    Departs = boss_db:find(Id),
    Users = boss_db:find(cl_user,[]),
    {ok, [{departs, Departs}, {ip, Req:peer_ip()}, {cl_user, Operator}, {users, Users}]}.

delete('GET',[Id]) ->
    boss_db:delete(Id),
    {redirect,[{action, "index"}]}.

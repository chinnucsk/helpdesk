-module(helpdesk_main_controller, [Req]).
-compile(export_all).

before_(_) ->
    user_lib:require_login(Req).

index('GET', [], ClUser) ->
  {ok, [{cl_user, ClUser},
        {ip,Req:peer_ip()},
        {all_request, boss_db:count(request)},
        {all_request_close, boss_db:count(request,[{status,"Close"}])}]}.

targetplan('GET', [], ClUser) ->
  {ok, [{cl_user, ClUser}]}.

depart_request('GET', [], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{depart_id, ClUser:depart_id()},{status,'not_equals',"Close"}],[{order_by,creation_time},descending]);
        true ->
            Requests = boss_db:find(request, [])
    end,
  {ok, [{cl_user, ClUser}, {requests, Requests},
        {count_depart_request, boss_db:count(request,[{depart_id, ClUser:depart_id()}])},
        {count_depart_request_notclose, boss_db:count(request,[{depart_id, ClUser:depart_id()},{status,'not_equals',"Close"}])},
        {count_depart_request_new, boss_db:count(request,[{depart_id, ClUser:depart_id()},{status,"New"}])}

       ]};

depart_request('GET', ["tag_order", Tag_order], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{depart_id, ClUser:depart_id()}],[{order_by, list_to_atom(Tag_order)},descending]);
        true ->
            Requests = boss_db:find(request, [])
    end,
  {ok, [{cl_user, ClUser}, {requests, Requests},
        {count, boss_db:count(request,[{depart_id, ClUser:depart_id()}])}
       ]};

depart_request('GET', ["tag_order", Tag_order, "tag_status", Tag_status], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{depart_id, ClUser:depart_id()}],[{order_by, list_to_atom(Tag_order)},descending]);
        true ->
            Requests = boss_db:find(request, [])
    end,
  {ok, [{cl_user, ClUser}, {requests, Requests},
        {count, boss_db:count(request,[{depart_id, ClUser:depart_id()}])}
       ]}.

user_request('GET', [], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{cl_user_id, ClUser:id()},{status,'not_equals',"Close"}],[{order_by, creation_time},descending]);
        true ->
            Requests = boss_db:find(request, [])
    end,
  {ok, [{cl_user, ClUser}, {requests, Requests},
        {count_user_request, boss_db:count(request,[{cl_user_id, ClUser:id()}])},
        {count_user_request_noclose, boss_db:count(request,[{cl_user_id, ClUser:id()},{status,'not_equals',"Close"}])},
        {count_user_request_new, boss_db:count(request,[{cl_user_id, ClUser:id()},{status,"New"}])}

   ]};

user_request('GET', ["tag_order", Tag_order], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{cl_user_id, ClUser:id()}],[{order_by, list_to_atom(Tag_order)},descending]);
        true ->
            Requests = boss_db:find(request, [])
    end,
  {ok, [{cl_user, ClUser}, {requests, Requests},{count, boss_db:count(request,[{cl_user_id, ClUser:id()}])}]}.

nope('GET', []) ->
  {ok, []}.

oops('GET', []) ->
  {ok, []}.

about('GET', [],ClUser) ->
  {ok, [{cl_user,ClUser}]}.

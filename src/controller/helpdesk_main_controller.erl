-module(helpdesk_main_controller, [Req]).
-compile(export_all).

before_(_) ->
    user_lib:require_login(Req).

index('GET', [], ClUser) ->
  {ok, [{cl_user, ClUser}]}.

targetplan('GET', [], ClUser) ->
  {ok, [{cl_user, ClUser}]}.

depart_request('GET', [], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{depart_id, ClUser:depart_id()}],[{order_by,close_time}]);
        true ->
            Requests = boss_db:find(request, [])
    end,
  {ok, [{cl_user, ClUser}, {requests, Requests},
        {count, boss_db:count(request,[{depart_id, ClUser:depart_id()}])}
       ]}.

user_request('GET', [], ClUser) ->
    case ClUser == undefined of
        false ->
            Requests = boss_db:find(request, [{cl_user_id, ClUser:id()}],[{order_by, close_time}]);
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

-module(helpdesk_user_controller, [Req]).
-compile(export_all).

login('GET', []) ->
    {ok, [{redirect, Req:header(referer)}]};

login('POST', []) ->
    UserName = Req:post_param("name"),
    case boss_db:find(cl_user, [{name, UserName}]) of
        [ClUser] ->
            case ClUser:check_password(Req:post_param("password")) of
                true ->
                   {redirect, proplists:get_value("redirect",
                       Req:post_params(), "/"), ClUser:login_cookies()};
                false ->
                    {ok, [{error, "Authentication error"}]}
            end;
        [] ->
            {ok, [{error, "Authentication error"}]}
    end.

logout('GET', []) ->
    {redirect, "/",
        [ mochiweb_cookies:cookie("cl_user_id", "", [{path, "/"}]),
            mochiweb_cookies:cookie("session_id", "", [{path, "/"}]) ]}.

register('GET', []) ->
    Departs = boss_db:find(depart,[]),
    {ok, [{departs, Departs}]};

register('POST', []) ->
    Email = Req:post_param("email"),
    UserName = Req:post_param("name"),
    Password = Req:post_param("password"), %%bcrypt:hashpw(Req:post_param("password"),bcrypt:gen_salt()),
    DepartId = Req:post_param("depart_id"),
    ClUser = cl_user:new(id, Email, UserName, Password, DepartId),
    Result = ClUser:save(),
    {ok, [Result]}.

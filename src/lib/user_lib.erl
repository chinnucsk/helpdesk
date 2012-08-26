-module(user_lib).
-compile(export_all).

hash_password(Password)->
    bcrypt:hashpw(Password, bcrypt:gen_salt()).

require_login(Req) ->
    case Req:cookie("cl_user_id") of
        undefined -> {ok, []};
        Id ->
            case boss_db:find(Id) of
                undefined -> {ok, []};
                ClUser ->
                    case ClUser:session_identifier() =:= Req:cookie("session_id") of
                        false -> {ok, []};
                        true -> {ok, ClUser}
                    end
            end
     end.


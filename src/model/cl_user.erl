-module(cl_user, 
[Id,
 Email,
 Name,
 Password::string(),
 DepartId]
).
-compile(export_all).

-belongs_to(depart).

-define(SETEC_ASTRONOMY, "Too many secrets").

session_identifier() ->
    mochihex:to_hex(erlang:md5(?SETEC_ASTRONOMY ++ Id)).

check_password(PasswordAttempt) ->
    Password =:= PasswordAttempt. %%bcrypt:hashpw(PasswordAttempt, Password).

login_cookies() ->
    [ mochiweb_cookies:cookie("cl_user_id", Id, [{path, "/"}]),
        mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}]) ].

validation_tests() ->
  [{fun() -> length(Name) > 0 end,
		"Please enter a name. "},
	{fun() -> length(Password) > 0 end,
		"Please enter a password. "},
%%	{fun() -> boss_db:find(cl_user, [{username, Username}]) == [] end,
%%		"Please choose a different name. "},
	{fun() -> length(Name) > 3 end,
		"Please enter a long name. "}
].
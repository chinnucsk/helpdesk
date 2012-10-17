[{boss, [
    {path, "../ChicagoBoss"},
    {applications, [cb_admin, helpdesk]},
    {db_host, "localhost"},
    {db_port, 5432},
    {db_adapter, pgsql},
    {db_database, "helpdesk"},
    {db_username, "helpdesk"},
    {db_password, "pass"},
    {log_dir, "log"},
    {server, mochiweb},
    {port, 8001},
    {session_adapter, mock},
    {session_key, "_boss_session"},
    {session_exp_time, 525600}
]},
{ helpdesk, [
    {path, "../helpdesk"},
    {base_url, "/"}
]},
{cb_admin, [
    {path, "../cb_admin"},
    {allow_ip_blocks, ["127.0.0.1"]},
    {base_url, "/admin"}
    ]}
].

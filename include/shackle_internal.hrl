-include("shackle.hrl").
-include("shackle_defaults.hrl").
-include_lib("opentelemetry_api/include/otel_tracer.hrl").

%% macros
-define(APP, shackle).
-define(CHILD(Mod), {Mod, {Mod, start_link, [Mod]}, permanent, 5000, worker, [Mod]}).
-define(GET_ENV(Key, Default), application:get_env(?APP, Key, Default)).
-define(LOOKUP(Key, List), ?LOOKUP(Key, List, undefined)).
-define(LOOKUP(Key, List, Default), shackle_utils:lookup(Key, List, Default)).
-define(METRICS(Client, Type, Key), shackle_hooks:metrics(Client, Type, Key, 1)).
-define(METRICS(Client, Type, Key, Value), shackle_hooks:metrics(Client, Type, Key, Value)).
-define(MSG_CONNECT, connect).
-define(SERVER, shackle_server).
-define(SUPERVISOR, shackle_sup).
-define(WARN(PoolName, Format, Data), shackle_utils:warning_msg(PoolName, Format, Data)).

%% ETS tables
-define(ETS_TABLE_POOL_INDEX, shackle_pool_index).
-define(ETS_TABLE_STATUS, shackle_status).

%% compatibility
-ifdef(OTP_RELEASE). %% OTP-21+
-define(EXCEPTION(Class, Reason, Stacktrace), Class:Reason:Stacktrace).
-define(GET_STACK(Stacktrace), Stacktrace).
-else.
-define(EXCEPTION(Class, Reason, _), Class:Reason).
-define(GET_STACK(_), erlang:get_stacktrace()).
-endif.

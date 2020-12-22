%%%-------------------------------------------------------------------
%% @doc erlang-starter-kit public API
%% @end
%%%-------------------------------------------------------------------

-module(abstract_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, Host} = inet:parse_address(os:getenv("ABSTRACT_HOST", "0.0.0.0")),
    Port = list_to_integer(os:getenv("ABSTRACT_PORT", "8089")),

    Routes = [{
        '_',
        [
            {"/status", abstract_status, []},
            {"/user", abstract_user, []},
            {"/login", abstract_login, []}
        ]
    }],
    Dispatch = cowboy_router:compile(Routes),

    TransOpts = [{ip, Host}, {port, Port}],
	ProtoOpts = #{env => #{dispatch => Dispatch}},

	{ok, _} = cowboy:start_clear(abstract_http_listener, TransOpts, ProtoOpts),

    abstract_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
	ok = cowboy:stop_listener(abstract_http_listener).

%%====================================================================
%% Internal functions
%%====================================================================

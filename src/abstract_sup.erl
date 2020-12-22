%%%-------------------------------------------------------------------
%% @doc erlang-starter-kit top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(abstract_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init(_Args) ->
    Procs = [],
    {ok, { {one_for_one, 10, 10}, Procs} }.

%%====================================================================
%% Internal functions
%%====================================================================

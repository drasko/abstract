-module(abstract_status).

-export([init/2]).

-include_lib("kernel/include/logger.hrl").

init(Req, Opts) ->
    ?LOG_NOTICE(#{req => Req}),
    Resp = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>},
        jsone:encode([{<<"status">>,<<"running">>}]),
        Req),
    {ok, Resp, Opts}.

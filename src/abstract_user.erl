-module(abstract_user).

-export([init/2]).

init(Req0, Opts) ->
	Method = cowboy_req:method(Req0),
	HasBody = cowboy_req:has_body(Req0),
	Req = maybe_user(Method, HasBody, Req0),
	{ok, Req, Opts}.

maybe_user(<<"POST">>, true, Req0) ->
	{ok, PostVals, Req} = cowboy_req:read_urlencoded_body(Req0),
	_Username = proplists:get_value(<<"username">>, PostVals),
	_Password = proplists:get_value(<<"password">>, PostVals),
	cowboy_req:reply(200, #{<<"location">> => <<"UUID">>}, Req);
maybe_user(<<"POST">>, false, Req) ->
	cowboy_req:reply(400, Req);
maybe_user(_, _, Req) ->
	%% Method not allowed.
	cowboy_req:reply(405, Req).


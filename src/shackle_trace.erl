-module(shackle_trace).
-include("shackle_internal.hrl").
-include_lib("opentelemetry_api/include/opentelemetry.hrl").

-export([start/1, finished/1, failed/2]).


-spec start(atom()) -> span_ctx().
start(PoolName) ->
    SpanName = erlang:list_to_binary(
        [<<"shackle_">>, erlang:atom_to_binary(PoolName, utf8)]),
    ?start_span(SpanName).


-spec finished(span_ctx()) -> span_ctx().
finished(SpanCtx) ->
    SpanStatus = opentelemetry:status(?OTEL_STATUS_OK, <<"">>),
    otel_span:set_status(SpanCtx, SpanStatus),
    otel_span:end_span(SpanCtx).


-spec failed(span_ctx(), atom()) -> span_ctx().
failed(SpanCtx, Status) ->
    StatusDescription = erlang:list_to_binary(
                          [<<"Shackle request failed: ">>,
                           erlang:atom_to_binary(Status, utf8)]),
    SpanStatus = opentelemetry:status(?OTEL_STATUS_ERROR, StatusDescription),
    otel_span:set_status(SpanCtx, SpanStatus),
    otel_span:end_span(SpanCtx).

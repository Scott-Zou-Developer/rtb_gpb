%% -*- coding: utf-8 -*-
%% @private
%% Automatically generated, do not edit
%% Generated by gpb_compile version 4.11.2
-module(test).

-export([encode_msg/1, encode_msg/2, encode_msg/3]).
-export([decode_msg/2, decode_msg/3]).
-export([merge_msgs/2, merge_msgs/3, merge_msgs/4]).
-export([verify_msg/1, verify_msg/2, verify_msg/3]).
-export([get_msg_defs/0]).
-export([get_msg_names/0]).
-export([get_group_names/0]).
-export([get_msg_or_group_names/0]).
-export([get_enum_names/0]).
-export([find_msg_def/1, fetch_msg_def/1]).
-export([find_enum_def/1, fetch_enum_def/1]).
-export([enum_symbol_by_value/2, enum_value_by_symbol/2]).
-export([get_service_names/0]).
-export([get_service_def/1]).
-export([get_rpc_names/1]).
-export([find_rpc_def/2, fetch_rpc_def/2]).
-export([fqbin_to_service_name/1]).
-export([service_name_to_fqbin/1]).
-export([fqbins_to_service_and_rpc_name/2]).
-export([service_and_rpc_name_to_fqbins/2]).
-export([fqbin_to_msg_name/1]).
-export([msg_name_to_fqbin/1]).
-export([fqbin_to_enum_name/1]).
-export([enum_name_to_fqbin/1]).
-export([get_package_name/0]).
-export([uses_packages/0]).
-export([source_basename/0]).
-export([get_all_source_basenames/0]).
-export([get_all_proto_names/0]).
-export([get_msg_containment/1]).
-export([get_pkg_containment/1]).
-export([get_service_containment/1]).
-export([get_rpc_containment/1]).
-export([get_enum_containment/1]).
-export([get_proto_by_msg_name_as_fqbin/1]).
-export([get_proto_by_service_name_as_fqbin/1]).
-export([get_proto_by_enum_name_as_fqbin/1]).
-export([get_protos_by_pkg_name_as_fqbin/1]).
-export([gpb_version_as_string/0, gpb_version_as_list/0]).

-include("test.hrl").
-include("gpb.hrl").

%% enumerated types

-export_type([]).

%% message types
-type 'Person'() :: #'Person'{}.

-type 'Cat'() :: #'Cat'{}.

-export_type(['Person'/0, 'Cat'/0]).

-spec encode_msg(#'Person'{} | #'Cat'{}) -> binary().
encode_msg(Msg) when tuple_size(Msg) >= 1 ->
    encode_msg(Msg, element(1, Msg), []).

-spec encode_msg(#'Person'{} | #'Cat'{}, atom() | list()) -> binary().
encode_msg(Msg, MsgName) when is_atom(MsgName) ->
    encode_msg(Msg, MsgName, []);
encode_msg(Msg, Opts)
    when tuple_size(Msg) >= 1, is_list(Opts) ->
    encode_msg(Msg, element(1, Msg), Opts).

-spec encode_msg(#'Person'{} | #'Cat'{}, atom(), list()) -> binary().
encode_msg(Msg, MsgName, Opts) ->
    case proplists:get_bool(verify, Opts) of
      true -> verify_msg(Msg, MsgName, Opts);
      false -> ok
    end,
    TrUserData = proplists:get_value(user_data, Opts),
    case MsgName of
      'Person' ->
	  encode_msg_Person(id(Msg, TrUserData), TrUserData);
      'Cat' -> encode_msg_Cat(id(Msg, TrUserData), TrUserData)
    end.


encode_msg_Person(Msg, TrUserData) ->
    encode_msg_Person(Msg, <<>>, TrUserData).


encode_msg_Person(#'Person'{name = F1, id = F2,
			    email = F3},
		  Bin, TrUserData) ->
    B1 = if F1 == undefined -> Bin;
	    true ->
		begin
		  TrF1 = id(F1, TrUserData),
		  e_type_string(TrF1, <<Bin/binary, 10>>, TrUserData)
		end
	 end,
    B2 = if F2 == undefined -> B1;
	    true ->
		begin
		  TrF2 = id(F2, TrUserData),
		  e_type_int32(TrF2, <<B1/binary, 16>>, TrUserData)
		end
	 end,
    if F3 == undefined -> B2;
       true ->
	   begin
	     TrF3 = id(F3, TrUserData),
	     e_type_string(TrF3, <<B2/binary, 26>>, TrUserData)
	   end
    end.

encode_msg_Cat(Msg, TrUserData) ->
    encode_msg_Cat(Msg, <<>>, TrUserData).


encode_msg_Cat(#'Cat'{name = F1, age = F2}, Bin,
	       TrUserData) ->
    B1 = if F1 == undefined -> Bin;
	    true ->
		begin
		  TrF1 = id(F1, TrUserData),
		  e_type_string(TrF1, <<Bin/binary, 10>>, TrUserData)
		end
	 end,
    if F2 == undefined -> B1;
       true ->
	   begin
	     TrF2 = id(F2, TrUserData),
	     e_type_int32(TrF2, <<B1/binary, 16>>, TrUserData)
	   end
    end.

-compile({nowarn_unused_function,e_type_sint/3}).
e_type_sint(Value, Bin, _TrUserData) when Value >= 0 ->
    e_varint(Value * 2, Bin);
e_type_sint(Value, Bin, _TrUserData) ->
    e_varint(Value * -2 - 1, Bin).

-compile({nowarn_unused_function,e_type_int32/3}).
e_type_int32(Value, Bin, _TrUserData)
    when 0 =< Value, Value =< 127 ->
    <<Bin/binary, Value>>;
e_type_int32(Value, Bin, _TrUserData) ->
    <<N:64/unsigned-native>> = <<Value:64/signed-native>>,
    e_varint(N, Bin).

-compile({nowarn_unused_function,e_type_int64/3}).
e_type_int64(Value, Bin, _TrUserData)
    when 0 =< Value, Value =< 127 ->
    <<Bin/binary, Value>>;
e_type_int64(Value, Bin, _TrUserData) ->
    <<N:64/unsigned-native>> = <<Value:64/signed-native>>,
    e_varint(N, Bin).

-compile({nowarn_unused_function,e_type_bool/3}).
e_type_bool(true, Bin, _TrUserData) ->
    <<Bin/binary, 1>>;
e_type_bool(false, Bin, _TrUserData) ->
    <<Bin/binary, 0>>;
e_type_bool(1, Bin, _TrUserData) -> <<Bin/binary, 1>>;
e_type_bool(0, Bin, _TrUserData) -> <<Bin/binary, 0>>.

-compile({nowarn_unused_function,e_type_string/3}).
e_type_string(S, Bin, _TrUserData) ->
    Utf8 = unicode:characters_to_binary(S),
    Bin2 = e_varint(byte_size(Utf8), Bin),
    <<Bin2/binary, Utf8/binary>>.

-compile({nowarn_unused_function,e_type_bytes/3}).
e_type_bytes(Bytes, Bin, _TrUserData)
    when is_binary(Bytes) ->
    Bin2 = e_varint(byte_size(Bytes), Bin),
    <<Bin2/binary, Bytes/binary>>;
e_type_bytes(Bytes, Bin, _TrUserData)
    when is_list(Bytes) ->
    BytesBin = iolist_to_binary(Bytes),
    Bin2 = e_varint(byte_size(BytesBin), Bin),
    <<Bin2/binary, BytesBin/binary>>.

-compile({nowarn_unused_function,e_type_fixed32/3}).
e_type_fixed32(Value, Bin, _TrUserData) ->
    <<Bin/binary, Value:32/little>>.

-compile({nowarn_unused_function,e_type_sfixed32/3}).
e_type_sfixed32(Value, Bin, _TrUserData) ->
    <<Bin/binary, Value:32/little-signed>>.

-compile({nowarn_unused_function,e_type_fixed64/3}).
e_type_fixed64(Value, Bin, _TrUserData) ->
    <<Bin/binary, Value:64/little>>.

-compile({nowarn_unused_function,e_type_sfixed64/3}).
e_type_sfixed64(Value, Bin, _TrUserData) ->
    <<Bin/binary, Value:64/little-signed>>.

-compile({nowarn_unused_function,e_type_float/3}).
e_type_float(V, Bin, _) when is_number(V) ->
    <<Bin/binary, V:32/little-float>>;
e_type_float(infinity, Bin, _) ->
    <<Bin/binary, 0:16, 128, 127>>;
e_type_float('-infinity', Bin, _) ->
    <<Bin/binary, 0:16, 128, 255>>;
e_type_float(nan, Bin, _) ->
    <<Bin/binary, 0:16, 192, 127>>.

-compile({nowarn_unused_function,e_type_double/3}).
e_type_double(V, Bin, _) when is_number(V) ->
    <<Bin/binary, V:64/little-float>>;
e_type_double(infinity, Bin, _) ->
    <<Bin/binary, 0:48, 240, 127>>;
e_type_double('-infinity', Bin, _) ->
    <<Bin/binary, 0:48, 240, 255>>;
e_type_double(nan, Bin, _) ->
    <<Bin/binary, 0:48, 248, 127>>.

-compile({nowarn_unused_function,e_varint/3}).
e_varint(N, Bin, _TrUserData) -> e_varint(N, Bin).

-compile({nowarn_unused_function,e_varint/2}).
e_varint(N, Bin) when N =< 127 -> <<Bin/binary, N>>;
e_varint(N, Bin) ->
    Bin2 = <<Bin/binary, (N band 127 bor 128)>>,
    e_varint(N bsr 7, Bin2).


decode_msg(Bin, MsgName) when is_binary(Bin) ->
    decode_msg(Bin, MsgName, []).

decode_msg(Bin, MsgName, Opts) when is_binary(Bin) ->
    TrUserData = proplists:get_value(user_data, Opts),
    decode_msg_1_catch(Bin, MsgName, TrUserData).

-ifdef('OTP_RELEASE').
decode_msg_1_catch(Bin, MsgName, TrUserData) ->
    try decode_msg_2_doit(MsgName, Bin, TrUserData)
    catch Class:Reason:StackTrace -> error({gpb_error,{decoding_failure, {Bin, MsgName, {Class, Reason, StackTrace}}}})
    end.
-else.
decode_msg_1_catch(Bin, MsgName, TrUserData) ->
    try decode_msg_2_doit(MsgName, Bin, TrUserData)
    catch Class:Reason ->
        StackTrace = erlang:get_stacktrace(),
        error({gpb_error,{decoding_failure, {Bin, MsgName, {Class, Reason, StackTrace}}}})
    end.
-endif.

decode_msg_2_doit('Person', Bin, TrUserData) ->
    id(decode_msg_Person(Bin, TrUserData), TrUserData);
decode_msg_2_doit('Cat', Bin, TrUserData) ->
    id(decode_msg_Cat(Bin, TrUserData), TrUserData).



decode_msg_Person(Bin, TrUserData) ->
    dfp_read_field_def_Person(Bin, 0, 0,
			      id(undefined, TrUserData),
			      id(undefined, TrUserData),
			      id(undefined, TrUserData), TrUserData).

dfp_read_field_def_Person(<<10, Rest/binary>>, Z1, Z2,
			  F@_1, F@_2, F@_3, TrUserData) ->
    d_field_Person_name(Rest, Z1, Z2, F@_1, F@_2, F@_3,
			TrUserData);
dfp_read_field_def_Person(<<16, Rest/binary>>, Z1, Z2,
			  F@_1, F@_2, F@_3, TrUserData) ->
    d_field_Person_id(Rest, Z1, Z2, F@_1, F@_2, F@_3,
		      TrUserData);
dfp_read_field_def_Person(<<26, Rest/binary>>, Z1, Z2,
			  F@_1, F@_2, F@_3, TrUserData) ->
    d_field_Person_email(Rest, Z1, Z2, F@_1, F@_2, F@_3,
			 TrUserData);
dfp_read_field_def_Person(<<>>, 0, 0, F@_1, F@_2, F@_3,
			  _) ->
    #'Person'{name = F@_1, id = F@_2, email = F@_3};
dfp_read_field_def_Person(Other, Z1, Z2, F@_1, F@_2,
			  F@_3, TrUserData) ->
    dg_read_field_def_Person(Other, Z1, Z2, F@_1, F@_2,
			     F@_3, TrUserData).

dg_read_field_def_Person(<<1:1, X:7, Rest/binary>>, N,
			 Acc, F@_1, F@_2, F@_3, TrUserData)
    when N < 32 - 7 ->
    dg_read_field_def_Person(Rest, N + 7, X bsl N + Acc,
			     F@_1, F@_2, F@_3, TrUserData);
dg_read_field_def_Person(<<0:1, X:7, Rest/binary>>, N,
			 Acc, F@_1, F@_2, F@_3, TrUserData) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_Person_name(Rest, 0, 0, F@_1, F@_2, F@_3,
			      TrUserData);
      16 ->
	  d_field_Person_id(Rest, 0, 0, F@_1, F@_2, F@_3,
			    TrUserData);
      26 ->
	  d_field_Person_email(Rest, 0, 0, F@_1, F@_2, F@_3,
			       TrUserData);
      _ ->
	  case Key band 7 of
	    0 ->
		skip_varint_Person(Rest, 0, 0, F@_1, F@_2, F@_3,
				   TrUserData);
	    1 ->
		skip_64_Person(Rest, 0, 0, F@_1, F@_2, F@_3,
			       TrUserData);
	    2 ->
		skip_length_delimited_Person(Rest, 0, 0, F@_1, F@_2,
					     F@_3, TrUserData);
	    3 ->
		skip_group_Person(Rest, Key bsr 3, 0, F@_1, F@_2, F@_3,
				  TrUserData);
	    5 ->
		skip_32_Person(Rest, 0, 0, F@_1, F@_2, F@_3, TrUserData)
	  end
    end;
dg_read_field_def_Person(<<>>, 0, 0, F@_1, F@_2, F@_3,
			 _) ->
    #'Person'{name = F@_1, id = F@_2, email = F@_3}.

d_field_Person_name(<<1:1, X:7, Rest/binary>>, N, Acc,
		    F@_1, F@_2, F@_3, TrUserData)
    when N < 57 ->
    d_field_Person_name(Rest, N + 7, X bsl N + Acc, F@_1,
			F@_2, F@_3, TrUserData);
d_field_Person_name(<<0:1, X:7, Rest/binary>>, N, Acc,
		    _, F@_2, F@_3, TrUserData) ->
    {NewFValue, RestF} = begin
			   Len = X bsl N + Acc,
			   <<Utf8:Len/binary, Rest2/binary>> = Rest,
			   {id(unicode:characters_to_list(Utf8, unicode),
			       TrUserData),
			    Rest2}
			 end,
    dfp_read_field_def_Person(RestF, 0, 0, NewFValue, F@_2,
			      F@_3, TrUserData).

d_field_Person_id(<<1:1, X:7, Rest/binary>>, N, Acc,
		  F@_1, F@_2, F@_3, TrUserData)
    when N < 57 ->
    d_field_Person_id(Rest, N + 7, X bsl N + Acc, F@_1,
		      F@_2, F@_3, TrUserData);
d_field_Person_id(<<0:1, X:7, Rest/binary>>, N, Acc,
		  F@_1, _, F@_3, TrUserData) ->
    {NewFValue, RestF} = {begin
			    <<Res:32/signed-native>> = <<(X bsl N +
							    Acc):32/unsigned-native>>,
			    id(Res, TrUserData)
			  end,
			  Rest},
    dfp_read_field_def_Person(RestF, 0, 0, F@_1, NewFValue,
			      F@_3, TrUserData).

d_field_Person_email(<<1:1, X:7, Rest/binary>>, N, Acc,
		     F@_1, F@_2, F@_3, TrUserData)
    when N < 57 ->
    d_field_Person_email(Rest, N + 7, X bsl N + Acc, F@_1,
			 F@_2, F@_3, TrUserData);
d_field_Person_email(<<0:1, X:7, Rest/binary>>, N, Acc,
		     F@_1, F@_2, _, TrUserData) ->
    {NewFValue, RestF} = begin
			   Len = X bsl N + Acc,
			   <<Utf8:Len/binary, Rest2/binary>> = Rest,
			   {id(unicode:characters_to_list(Utf8, unicode),
			       TrUserData),
			    Rest2}
			 end,
    dfp_read_field_def_Person(RestF, 0, 0, F@_1, F@_2,
			      NewFValue, TrUserData).

skip_varint_Person(<<1:1, _:7, Rest/binary>>, Z1, Z2,
		   F@_1, F@_2, F@_3, TrUserData) ->
    skip_varint_Person(Rest, Z1, Z2, F@_1, F@_2, F@_3,
		       TrUserData);
skip_varint_Person(<<0:1, _:7, Rest/binary>>, Z1, Z2,
		   F@_1, F@_2, F@_3, TrUserData) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F@_1, F@_2,
			      F@_3, TrUserData).

skip_length_delimited_Person(<<1:1, X:7, Rest/binary>>,
			     N, Acc, F@_1, F@_2, F@_3, TrUserData)
    when N < 57 ->
    skip_length_delimited_Person(Rest, N + 7, X bsl N + Acc,
				 F@_1, F@_2, F@_3, TrUserData);
skip_length_delimited_Person(<<0:1, X:7, Rest/binary>>,
			     N, Acc, F@_1, F@_2, F@_3, TrUserData) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_Person(Rest2, 0, 0, F@_1, F@_2, F@_3,
			      TrUserData).

skip_group_Person(Bin, FNum, Z2, F@_1, F@_2, F@_3,
		  TrUserData) ->
    {_, Rest} = read_group(Bin, FNum),
    dfp_read_field_def_Person(Rest, 0, Z2, F@_1, F@_2, F@_3,
			      TrUserData).

skip_32_Person(<<_:32, Rest/binary>>, Z1, Z2, F@_1,
	       F@_2, F@_3, TrUserData) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F@_1, F@_2,
			      F@_3, TrUserData).

skip_64_Person(<<_:64, Rest/binary>>, Z1, Z2, F@_1,
	       F@_2, F@_3, TrUserData) ->
    dfp_read_field_def_Person(Rest, Z1, Z2, F@_1, F@_2,
			      F@_3, TrUserData).

decode_msg_Cat(Bin, TrUserData) ->
    dfp_read_field_def_Cat(Bin, 0, 0,
			   id(undefined, TrUserData), id(undefined, TrUserData),
			   TrUserData).

dfp_read_field_def_Cat(<<10, Rest/binary>>, Z1, Z2,
		       F@_1, F@_2, TrUserData) ->
    d_field_Cat_name(Rest, Z1, Z2, F@_1, F@_2, TrUserData);
dfp_read_field_def_Cat(<<16, Rest/binary>>, Z1, Z2,
		       F@_1, F@_2, TrUserData) ->
    d_field_Cat_age(Rest, Z1, Z2, F@_1, F@_2, TrUserData);
dfp_read_field_def_Cat(<<>>, 0, 0, F@_1, F@_2, _) ->
    #'Cat'{name = F@_1, age = F@_2};
dfp_read_field_def_Cat(Other, Z1, Z2, F@_1, F@_2,
		       TrUserData) ->
    dg_read_field_def_Cat(Other, Z1, Z2, F@_1, F@_2,
			  TrUserData).

dg_read_field_def_Cat(<<1:1, X:7, Rest/binary>>, N, Acc,
		      F@_1, F@_2, TrUserData)
    when N < 32 - 7 ->
    dg_read_field_def_Cat(Rest, N + 7, X bsl N + Acc, F@_1,
			  F@_2, TrUserData);
dg_read_field_def_Cat(<<0:1, X:7, Rest/binary>>, N, Acc,
		      F@_1, F@_2, TrUserData) ->
    Key = X bsl N + Acc,
    case Key of
      10 ->
	  d_field_Cat_name(Rest, 0, 0, F@_1, F@_2, TrUserData);
      16 ->
	  d_field_Cat_age(Rest, 0, 0, F@_1, F@_2, TrUserData);
      _ ->
	  case Key band 7 of
	    0 ->
		skip_varint_Cat(Rest, 0, 0, F@_1, F@_2, TrUserData);
	    1 -> skip_64_Cat(Rest, 0, 0, F@_1, F@_2, TrUserData);
	    2 ->
		skip_length_delimited_Cat(Rest, 0, 0, F@_1, F@_2,
					  TrUserData);
	    3 ->
		skip_group_Cat(Rest, Key bsr 3, 0, F@_1, F@_2,
			       TrUserData);
	    5 -> skip_32_Cat(Rest, 0, 0, F@_1, F@_2, TrUserData)
	  end
    end;
dg_read_field_def_Cat(<<>>, 0, 0, F@_1, F@_2, _) ->
    #'Cat'{name = F@_1, age = F@_2}.

d_field_Cat_name(<<1:1, X:7, Rest/binary>>, N, Acc,
		 F@_1, F@_2, TrUserData)
    when N < 57 ->
    d_field_Cat_name(Rest, N + 7, X bsl N + Acc, F@_1, F@_2,
		     TrUserData);
d_field_Cat_name(<<0:1, X:7, Rest/binary>>, N, Acc, _,
		 F@_2, TrUserData) ->
    {NewFValue, RestF} = begin
			   Len = X bsl N + Acc,
			   <<Utf8:Len/binary, Rest2/binary>> = Rest,
			   {id(unicode:characters_to_list(Utf8, unicode),
			       TrUserData),
			    Rest2}
			 end,
    dfp_read_field_def_Cat(RestF, 0, 0, NewFValue, F@_2,
			   TrUserData).

d_field_Cat_age(<<1:1, X:7, Rest/binary>>, N, Acc, F@_1,
		F@_2, TrUserData)
    when N < 57 ->
    d_field_Cat_age(Rest, N + 7, X bsl N + Acc, F@_1, F@_2,
		    TrUserData);
d_field_Cat_age(<<0:1, X:7, Rest/binary>>, N, Acc, F@_1,
		_, TrUserData) ->
    {NewFValue, RestF} = {begin
			    <<Res:32/signed-native>> = <<(X bsl N +
							    Acc):32/unsigned-native>>,
			    id(Res, TrUserData)
			  end,
			  Rest},
    dfp_read_field_def_Cat(RestF, 0, 0, F@_1, NewFValue,
			   TrUserData).

skip_varint_Cat(<<1:1, _:7, Rest/binary>>, Z1, Z2, F@_1,
		F@_2, TrUserData) ->
    skip_varint_Cat(Rest, Z1, Z2, F@_1, F@_2, TrUserData);
skip_varint_Cat(<<0:1, _:7, Rest/binary>>, Z1, Z2, F@_1,
		F@_2, TrUserData) ->
    dfp_read_field_def_Cat(Rest, Z1, Z2, F@_1, F@_2,
			   TrUserData).

skip_length_delimited_Cat(<<1:1, X:7, Rest/binary>>, N,
			  Acc, F@_1, F@_2, TrUserData)
    when N < 57 ->
    skip_length_delimited_Cat(Rest, N + 7, X bsl N + Acc,
			      F@_1, F@_2, TrUserData);
skip_length_delimited_Cat(<<0:1, X:7, Rest/binary>>, N,
			  Acc, F@_1, F@_2, TrUserData) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    dfp_read_field_def_Cat(Rest2, 0, 0, F@_1, F@_2,
			   TrUserData).

skip_group_Cat(Bin, FNum, Z2, F@_1, F@_2, TrUserData) ->
    {_, Rest} = read_group(Bin, FNum),
    dfp_read_field_def_Cat(Rest, 0, Z2, F@_1, F@_2,
			   TrUserData).

skip_32_Cat(<<_:32, Rest/binary>>, Z1, Z2, F@_1, F@_2,
	    TrUserData) ->
    dfp_read_field_def_Cat(Rest, Z1, Z2, F@_1, F@_2,
			   TrUserData).

skip_64_Cat(<<_:64, Rest/binary>>, Z1, Z2, F@_1, F@_2,
	    TrUserData) ->
    dfp_read_field_def_Cat(Rest, Z1, Z2, F@_1, F@_2,
			   TrUserData).

read_group(Bin, FieldNum) ->
    {NumBytes, EndTagLen} = read_gr_b(Bin, 0, 0, 0, 0, FieldNum),
    <<Group:NumBytes/binary, _:EndTagLen/binary, Rest/binary>> = Bin,
    {Group, Rest}.

%% Like skipping over fields, but record the total length,
%% Each field is <(FieldNum bsl 3) bor FieldType> ++ <FieldValue>
%% Record the length because varints may be non-optimally encoded.
%%
%% Groups can be nested, but assume the same FieldNum cannot be nested
%% because group field numbers are shared with the rest of the fields
%% numbers. Thus we can search just for an group-end with the same
%% field number.
%%
%% (The only time the same group field number could occur would
%% be in a nested sub message, but then it would be inside a
%% length-delimited entry, which we skip-read by length.)
read_gr_b(<<1:1, X:7, Tl/binary>>, N, Acc, NumBytes, TagLen, FieldNum)
  when N < (32-7) ->
    read_gr_b(Tl, N+7, X bsl N + Acc, NumBytes, TagLen+1, FieldNum);
read_gr_b(<<0:1, X:7, Tl/binary>>, N, Acc, NumBytes, TagLen,
          FieldNum) ->
    Key = X bsl N + Acc,
    TagLen1 = TagLen + 1,
    case {Key bsr 3, Key band 7} of
        {FieldNum, 4} -> % 4 = group_end
            {NumBytes, TagLen1};
        {_, 0} -> % 0 = varint
            read_gr_vi(Tl, 0, NumBytes + TagLen1, FieldNum);
        {_, 1} -> % 1 = bits64
            <<_:64, Tl2/binary>> = Tl,
            read_gr_b(Tl2, 0, 0, NumBytes + TagLen1 + 8, 0, FieldNum);
        {_, 2} -> % 2 = length_delimited
            read_gr_ld(Tl, 0, 0, NumBytes + TagLen1, FieldNum);
        {_, 3} -> % 3 = group_start
            read_gr_b(Tl, 0, 0, NumBytes + TagLen1, 0, FieldNum);
        {_, 4} -> % 4 = group_end
            read_gr_b(Tl, 0, 0, NumBytes + TagLen1, 0, FieldNum);
        {_, 5} -> % 5 = bits32
            <<_:32, Tl2/binary>> = Tl,
            read_gr_b(Tl2, 0, 0, NumBytes + TagLen1 + 4, 0, FieldNum)
    end.

read_gr_vi(<<1:1, _:7, Tl/binary>>, N, NumBytes, FieldNum)
  when N < (64-7) ->
    read_gr_vi(Tl, N+7, NumBytes+1, FieldNum);
read_gr_vi(<<0:1, _:7, Tl/binary>>, _, NumBytes, FieldNum) ->
    read_gr_b(Tl, 0, 0, NumBytes+1, 0, FieldNum).

read_gr_ld(<<1:1, X:7, Tl/binary>>, N, Acc, NumBytes, FieldNum)
  when N < (64-7) ->
    read_gr_ld(Tl, N+7, X bsl N + Acc, NumBytes+1, FieldNum);
read_gr_ld(<<0:1, X:7, Tl/binary>>, N, Acc, NumBytes, FieldNum) ->
    Len = X bsl N + Acc,
    NumBytes1 = NumBytes + 1,
    <<_:Len/binary, Tl2/binary>> = Tl,
    read_gr_b(Tl2, 0, 0, NumBytes1 + Len, 0, FieldNum).

merge_msgs(Prev, New)
    when element(1, Prev) =:= element(1, New) ->
    merge_msgs(Prev, New, element(1, Prev), []).

merge_msgs(Prev, New, MsgName) when is_atom(MsgName) ->
    merge_msgs(Prev, New, MsgName, []);
merge_msgs(Prev, New, Opts)
    when element(1, Prev) =:= element(1, New),
	 is_list(Opts) ->
    merge_msgs(Prev, New, element(1, Prev), Opts).

merge_msgs(Prev, New, MsgName, Opts) ->
    TrUserData = proplists:get_value(user_data, Opts),
    case MsgName of
      'Person' -> merge_msg_Person(Prev, New, TrUserData);
      'Cat' -> merge_msg_Cat(Prev, New, TrUserData)
    end.

-compile({nowarn_unused_function,merge_msg_Person/3}).
merge_msg_Person(#'Person'{name = PFname, id = PFid,
			   email = PFemail},
		 #'Person'{name = NFname, id = NFid, email = NFemail},
		 _) ->
    #'Person'{name =
		  if NFname =:= undefined -> PFname;
		     true -> NFname
		  end,
	      id =
		  if NFid =:= undefined -> PFid;
		     true -> NFid
		  end,
	      email =
		  if NFemail =:= undefined -> PFemail;
		     true -> NFemail
		  end}.

-compile({nowarn_unused_function,merge_msg_Cat/3}).
merge_msg_Cat(#'Cat'{name = PFname, age = PFage},
	      #'Cat'{name = NFname, age = NFage}, _) ->
    #'Cat'{name =
	       if NFname =:= undefined -> PFname;
		  true -> NFname
	       end,
	   age =
	       if NFage =:= undefined -> PFage;
		  true -> NFage
	       end}.


verify_msg(Msg) when tuple_size(Msg) >= 1 ->
    verify_msg(Msg, element(1, Msg), []);
verify_msg(X) ->
    mk_type_error(not_a_known_message, X, []).

verify_msg(Msg, MsgName) when is_atom(MsgName) ->
    verify_msg(Msg, MsgName, []);
verify_msg(Msg, Opts) when tuple_size(Msg) >= 1 ->
    verify_msg(Msg, element(1, Msg), Opts);
verify_msg(X, _Opts) ->
    mk_type_error(not_a_known_message, X, []).

verify_msg(Msg, MsgName, Opts) ->
    TrUserData = proplists:get_value(user_data, Opts),
    case MsgName of
      'Person' -> v_msg_Person(Msg, [MsgName], TrUserData);
      'Cat' -> v_msg_Cat(Msg, [MsgName], TrUserData);
      _ -> mk_type_error(not_a_known_message, Msg, [])
    end.


-compile({nowarn_unused_function,v_msg_Person/3}).
-dialyzer({nowarn_function,v_msg_Person/3}).
v_msg_Person(#'Person'{name = F1, id = F2, email = F3},
	     Path, TrUserData) ->
    if F1 == undefined -> ok;
       true -> v_type_string(F1, [name | Path], TrUserData)
    end,
    if F2 == undefined -> ok;
       true -> v_type_int32(F2, [id | Path], TrUserData)
    end,
    if F3 == undefined -> ok;
       true -> v_type_string(F3, [email | Path], TrUserData)
    end,
    ok;
v_msg_Person(X, Path, _TrUserData) ->
    mk_type_error({expected_msg, 'Person'}, X, Path).

-compile({nowarn_unused_function,v_msg_Cat/3}).
-dialyzer({nowarn_function,v_msg_Cat/3}).
v_msg_Cat(#'Cat'{name = F1, age = F2}, Path,
	  TrUserData) ->
    if F1 == undefined -> ok;
       true -> v_type_string(F1, [name | Path], TrUserData)
    end,
    if F2 == undefined -> ok;
       true -> v_type_int32(F2, [age | Path], TrUserData)
    end,
    ok;
v_msg_Cat(X, Path, _TrUserData) ->
    mk_type_error({expected_msg, 'Cat'}, X, Path).

-compile({nowarn_unused_function,v_type_int32/3}).
-dialyzer({nowarn_function,v_type_int32/3}).
v_type_int32(N, _Path, _TrUserData)
    when -2147483648 =< N, N =< 2147483647 ->
    ok;
v_type_int32(N, Path, _TrUserData) when is_integer(N) ->
    mk_type_error({value_out_of_range, int32, signed, 32},
		  N, Path);
v_type_int32(X, Path, _TrUserData) ->
    mk_type_error({bad_integer, int32, signed, 32}, X,
		  Path).

-compile({nowarn_unused_function,v_type_string/3}).
-dialyzer({nowarn_function,v_type_string/3}).
v_type_string(S, Path, _TrUserData)
    when is_list(S); is_binary(S) ->
    try unicode:characters_to_binary(S) of
      B when is_binary(B) -> ok;
      {error, _, _} ->
	  mk_type_error(bad_unicode_string, S, Path)
    catch
      error:badarg ->
	  mk_type_error(bad_unicode_string, S, Path)
    end;
v_type_string(X, Path, _TrUserData) ->
    mk_type_error(bad_unicode_string, X, Path).

-compile({nowarn_unused_function,mk_type_error/3}).
-spec mk_type_error(_, _, list()) -> no_return().
mk_type_error(Error, ValueSeen, Path) ->
    Path2 = prettify_path(Path),
    erlang:error({gpb_type_error,
		  {Error, [{value, ValueSeen}, {path, Path2}]}}).


-compile({nowarn_unused_function,prettify_path/1}).
-dialyzer({nowarn_function,prettify_path/1}).
prettify_path([]) -> top_level;
prettify_path(PathR) ->
    list_to_atom(lists:append(lists:join(".",
					 lists:map(fun atom_to_list/1,
						   lists:reverse(PathR))))).


-compile({nowarn_unused_function,id/2}).
-compile({inline,id/2}).
id(X, _TrUserData) -> X.

-compile({nowarn_unused_function,v_ok/3}).
-compile({inline,v_ok/3}).
v_ok(_Value, _Path, _TrUserData) -> ok.

-compile({nowarn_unused_function,m_overwrite/3}).
-compile({inline,m_overwrite/3}).
m_overwrite(_Prev, New, _TrUserData) -> New.

-compile({nowarn_unused_function,cons/3}).
-compile({inline,cons/3}).
cons(Elem, Acc, _TrUserData) -> [Elem | Acc].

-compile({nowarn_unused_function,lists_reverse/2}).
-compile({inline,lists_reverse/2}).
'lists_reverse'(L, _TrUserData) -> lists:reverse(L).
-compile({nowarn_unused_function,'erlang_++'/3}).
-compile({inline,'erlang_++'/3}).
'erlang_++'(A, B, _TrUserData) -> A ++ B.


get_msg_defs() ->
    [{{msg, 'Person'},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = optional, opts = []},
       #field{name = id, fnum = 2, rnum = 3, type = int32,
	      occurrence = optional, opts = []},
       #field{name = email, fnum = 3, rnum = 4, type = string,
	      occurrence = optional, opts = []}]},
     {{msg, 'Cat'},
      [#field{name = name, fnum = 1, rnum = 2, type = string,
	      occurrence = optional, opts = []},
       #field{name = age, fnum = 2, rnum = 3, type = int32,
	      occurrence = optional, opts = []}]}].


get_msg_names() -> ['Person', 'Cat'].


get_group_names() -> [].


get_msg_or_group_names() -> ['Person', 'Cat'].


get_enum_names() -> [].


fetch_msg_def(MsgName) ->
    case find_msg_def(MsgName) of
      Fs when is_list(Fs) -> Fs;
      error -> erlang:error({no_such_msg, MsgName})
    end.


-spec fetch_enum_def(_) -> no_return().
fetch_enum_def(EnumName) ->
    erlang:error({no_such_enum, EnumName}).


find_msg_def('Person') ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = optional, opts = []},
     #field{name = id, fnum = 2, rnum = 3, type = int32,
	    occurrence = optional, opts = []},
     #field{name = email, fnum = 3, rnum = 4, type = string,
	    occurrence = optional, opts = []}];
find_msg_def('Cat') ->
    [#field{name = name, fnum = 1, rnum = 2, type = string,
	    occurrence = optional, opts = []},
     #field{name = age, fnum = 2, rnum = 3, type = int32,
	    occurrence = optional, opts = []}];
find_msg_def(_) -> error.


find_enum_def(_) -> error.


-spec enum_symbol_by_value(_, _) -> no_return().
enum_symbol_by_value(E, V) ->
    erlang:error({no_enum_defs, E, V}).


-spec enum_value_by_symbol(_, _) -> no_return().
enum_value_by_symbol(E, V) ->
    erlang:error({no_enum_defs, E, V}).



get_service_names() -> [].


get_service_def(_) -> error.


get_rpc_names(_) -> error.


find_rpc_def(_, _) -> error.



-spec fetch_rpc_def(_, _) -> no_return().
fetch_rpc_def(ServiceName, RpcName) ->
    erlang:error({no_such_rpc, ServiceName, RpcName}).


%% Convert a a fully qualified (ie with package name) service name
%% as a binary to a service name as an atom.
-spec fqbin_to_service_name(_) -> no_return().
fqbin_to_service_name(X) ->
    error({gpb_error, {badservice, X}}).


%% Convert a service name as an atom to a fully qualified
%% (ie with package name) name as a binary.
-spec service_name_to_fqbin(_) -> no_return().
service_name_to_fqbin(X) ->
    error({gpb_error, {badservice, X}}).


%% Convert a a fully qualified (ie with package name) service name
%% and an rpc name, both as binaries to a service name and an rpc
%% name, as atoms.
-spec fqbins_to_service_and_rpc_name(_, _) -> no_return().
fqbins_to_service_and_rpc_name(S, R) ->
    error({gpb_error, {badservice_or_rpc, {S, R}}}).


%% Convert a service name and an rpc name, both as atoms,
%% to a fully qualified (ie with package name) service name and
%% an rpc name as binaries.
-spec service_and_rpc_name_to_fqbins(_, _) -> no_return().
service_and_rpc_name_to_fqbins(S, R) ->
    error({gpb_error, {badservice_or_rpc, {S, R}}}).


fqbin_to_msg_name(<<"Person">>) -> 'Person';
fqbin_to_msg_name(<<"Cat">>) -> 'Cat';
fqbin_to_msg_name(E) -> error({gpb_error, {badmsg, E}}).


msg_name_to_fqbin('Person') -> <<"Person">>;
msg_name_to_fqbin('Cat') -> <<"Cat">>;
msg_name_to_fqbin(E) -> error({gpb_error, {badmsg, E}}).


-spec fqbin_to_enum_name(_) -> no_return().
fqbin_to_enum_name(E) ->
    error({gpb_error, {badenum, E}}).


-spec enum_name_to_fqbin(_) -> no_return().
enum_name_to_fqbin(E) ->
    error({gpb_error, {badenum, E}}).


get_package_name() -> undefined.


%% Whether or not the message names
%% are prepended with package name or not.
uses_packages() -> false.


source_basename() -> "test.proto".


%% Retrieve all proto file names, also imported ones.
%% The order is top-down. The first element is always the main
%% source file. The files are returned with extension,
%% see get_all_proto_names/0 for a version that returns
%% the basenames sans extension
get_all_source_basenames() -> ["test.proto"].


%% Retrieve all proto file names, also imported ones.
%% The order is top-down. The first element is always the main
%% source file. The files are returned sans .proto extension,
%% to make it easier to use them with the various get_xyz_containment
%% functions.
get_all_proto_names() -> ["test"].


get_msg_containment("test") -> ['Cat', 'Person'];
get_msg_containment(P) ->
    error({gpb_error, {badproto, P}}).


get_pkg_containment("test") -> undefined;
get_pkg_containment(P) ->
    error({gpb_error, {badproto, P}}).


get_service_containment("test") -> [];
get_service_containment(P) ->
    error({gpb_error, {badproto, P}}).


get_rpc_containment("test") -> [];
get_rpc_containment(P) ->
    error({gpb_error, {badproto, P}}).


get_enum_containment("test") -> [];
get_enum_containment(P) ->
    error({gpb_error, {badproto, P}}).


get_proto_by_msg_name_as_fqbin(<<"Cat">>) -> "test";
get_proto_by_msg_name_as_fqbin(<<"Person">>) -> "test";
get_proto_by_msg_name_as_fqbin(E) ->
    error({gpb_error, {badmsg, E}}).


-spec get_proto_by_service_name_as_fqbin(_) -> no_return().
get_proto_by_service_name_as_fqbin(E) ->
    error({gpb_error, {badservice, E}}).


-spec get_proto_by_enum_name_as_fqbin(_) -> no_return().
get_proto_by_enum_name_as_fqbin(E) ->
    error({gpb_error, {badenum, E}}).


-spec get_protos_by_pkg_name_as_fqbin(_) -> no_return().
get_protos_by_pkg_name_as_fqbin(E) ->
    error({gpb_error, {badpkg, E}}).



gpb_version_as_string() ->
    "4.11.2".

gpb_version_as_list() ->
    [4,11,2].

%% -*- coding: utf-8 -*-
%% Automatically generated, do not edit
%% Generated by gpb_compile version 4.11.2

-ifndef(test).
-define(test, true).

-define(test_gpb_version, "4.11.2").

-ifndef('PERSON_PB_H').
-define('PERSON_PB_H', true).
-record('Person',
        {name                   :: iodata() | undefined, % = 1
         id                     :: integer() | undefined, % = 2, 32 bits
         email                  :: iodata() | undefined % = 3
        }).
-endif.

-ifndef('CAT_PB_H').
-define('CAT_PB_H', true).
-record('Cat',
        {name                   :: iodata() | undefined, % = 1
         age                    :: integer() | undefined % = 2, 32 bits
        }).
-endif.

-endif.

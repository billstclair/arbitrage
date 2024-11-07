---------------------------------------------------------------------
--
-- Types.elm
-- Shared types for Ethereum.
-- Copyright (c) 2024 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module Eth.Types exposing (Opcode)


type alias Opcode =
    { opcode : Int
    , name : String
    , gas : Int
    , input : String
    , output : String
    , description : String
    }

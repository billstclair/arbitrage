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


module Eth.Types exposing (Address, JsonOpcode, Opcode, Param(..))

import Bytes exposing (Bytes)


type alias Opcode =
    { opcode : Int
    , name : String
    , gas : Int
    , input : String
    , output : String
    , description : String
    }


type alias JsonOpcode =
    { jsonrpc : String
    , method : String
    , name : String
    , params : List Param
    , description : String
    }


type Param
    = String String
    | Int Int
    | Transaction
        { nonce : Int
        , type_ : Int -- Transaction type
        , from : Address -- Source of the transaction call. Useful to impersonate another account.
        , to : Address -- Target contract
        , gas : Int -- Gas limit
        , value : Int
        , data : Bytes -- Transaction call input
        , gas_price : Int -- The gas price willing to be paid by the sender in wei
        , max_fee_per_gas : Int -- The maximum total fee per gas the sender is willing to pay (includes the network / base fee and miner / priority fee) in wei
        , max_priority_fee_per_gas : Int -- Maximum fee per gas the sender is willing to pay to miners in wei
        , max_fee_per_blob_gas : Int -- The maximum total fee per gas the sender is willing to pay for blob gas in wei
        }


type alias Address =
    Int

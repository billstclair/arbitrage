---------------------------------------------------------------------
--
-- View.elm
-- View Ethereum VM opcodes.
-- Copyright (c) 2024 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module Eth.View exposing (view)

import Eth.Opcodes exposing (opcodes)
import Eth.Types exposing (Opcode)
import Html exposing (Attribute, Html, a, h2, node, p, table, td, text, th, tr)
import Html.Attributes as Attributes exposing (href, style)
import Html.Events exposing (keyCode, on)


view : List Opcode -> Html msg
view opcodes =
    table []
        (opcodesHeader
            :: List.map viewOpcode opcodes
        )


opcodesHeader : Html msg
opcodesHeader =
    tr []
        [ th [] [ text "opcode" ]
        , th [] [ text "name" ]
        , th [] [ text "gas" ]
        , th [] [ text "input" ]
        , th [] [ text "output" ]
        , th [] [ text "description" ]
        ]


stringTD : String -> Html msg
stringTD s =
    td [] [ text s ]


viewOpcode : Opcode -> Html msg
viewOpcode opcode =
    tr []
        [ stringTD (String.fromInt opcode.opcode)
        , stringTD opcode.name
        , stringTD (String.fromInt opcode.gas)
        , stringTD opcode.input
        , stringTD opcode.output
        , stringTD opcode.description
        ]

--------------------------------------------------------------------
--
-- Docs.elm
-- Show Ethereum JsonRPC docs.
-- Copyright (c) 2024 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module Docs exposing (main)

import Arbitrage.Arbitrage as Arbitrage
import Arbitrage.Types exposing (Coin, Price, Trader)
import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Char
import Cmd.Extra exposing (withCmd, withCmds, withNoCmd)
import Dict exposing (Dict)
import Html exposing (Attribute, Html, h2, p, text)
import Html.Attributes as Attributes exposing (style)
import Html.Events exposing (keyCode, on)
import Json.Decode as JD exposing (Decoder, Value)
import Json.Encode as JE
import JsonTree exposing (TaggedValue(..))
import Task
import Url exposing (Url)


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = HandleUrlRequest
        , onUrlChange = HandleUrlChange
        }


view : Model -> Document Msg
view model =
    { title = "Ethereum JSON-RPC Docs"
    , body =
        [ h2 []
            [ text "Ethereum JSON-RPC Docs" ]
        , p []
            [ text "View JSON-RPC Json, with interactive twist-downs." ]
        , p []
            [ JsonTree.view model.tree model.config model.state ]
        ]
    }


type alias Model =
    { state : JsonTree.State
    , tree : JsonTree.Node
    , config : JsonTree.Config Msg
    }


type Msg
    = Noop
    | HandleUrlRequest UrlRequest
    | HandleUrlChange Url


init : Value -> url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model : Model
        model =
            { state = JsonTree.defaultState
            , tree =
                { value = TNull
                , keyPath = ""
                }
            , config =
                { onSelect = Nothing
                , toMsg = \state -> Noop
                }
            }
    in
    model |> withNoCmd


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    model |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []

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
import Html exposing (Attribute, Html, button, h2, p, text)
import Html.Attributes as Attributes exposing (style)
import Html.Events exposing (keyCode, on, onClick)
import Http
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
    let
        config =
            { onSelect = Nothing
            , toMsg = SetState
            }
    in
    { title = "Ethereum JSON-RPC Docs"
    , body =
        [ h2 []
            [ text "Ethereum JSON-RPC Docs" ]
        , p []
            [ text "View JSON-RPC Json, with interactive twist-downs." ]
        , p []
            [ button [ onClick ExpandAll ]
                [ text "Expand All" ]
            , text " "
            , button [ onClick CollapseSome ]
                [ text "Collapse Some" ]
            ]
        , p []
            [ JsonTree.view model.tree config model.state ]
        ]
    }


type alias Model =
    { state : JsonTree.State
    , tree : JsonTree.Node
    }


type Msg
    = Noop
    | HandleUrlRequest UrlRequest
    | HandleUrlChange Url
    | SetState JsonTree.State
    | GotJson (Result Http.Error String)
    | ExpandAll
    | CollapseSome


jsonFile : String
jsonFile =
    "openrpc.json"


init : Value -> url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model : Model
        model =
            { tree =
                { value = TNull
                , keyPath = ""
                }
            , state = JsonTree.defaultState
            }

        cmd =
            Http.get
                { url = jsonFile
                , expect = Http.expectString GotJson
                }
    in
    model |> withCmd cmd


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetState state ->
            { model | state = state } |> withNoCmd

        GotJson result ->
            case result of
                Err _ ->
                    model |> withNoCmd

                Ok string ->
                    case JsonTree.parseString string of
                        Err _ ->
                            model |> withNoCmd

                        Ok node ->
                            { model
                                | tree =
                                    { value = TList [ node ]
                                    , keyPath = ""
                                    }
                                , state =
                                    JsonTree.collapseToDepth 3 node model.state
                            }
                                |> withNoCmd

        ExpandAll ->
            { model
                | state = JsonTree.expandAll model.state
            }
                |> withNoCmd

        CollapseSome ->
            { model
                | state = JsonTree.collapseToDepth 4 model.tree model.state
            }
                |> withNoCmd

        _ ->
            model |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []

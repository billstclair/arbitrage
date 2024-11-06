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
import Html exposing (Attribute, Html, button, h2, input, p, text)
import Html.Attributes as Attributes exposing (size, style, value)
import Html.Events exposing (keyCode, on, onClick, onInput)
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
            , text " "
            , input
                [ onInput InputSome
                , value model.someString
                , size 2
                , onKeyDown
                    (\code ->
                        if code == 13 then
                            CollapseSome

                        else
                            Noop
                    )
                ]
                []
            ]
        , p []
            [ JsonTree.view model.tree config model.state ]
        ]
    }


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (JD.map tagger keyCode)


type alias Model =
    { state : JsonTree.State
    , tree : JsonTree.Node
    , someString : String
    , some : Int
    }


type Msg
    = Noop
    | HandleUrlRequest UrlRequest
    | HandleUrlChange Url
    | SetState JsonTree.State
    | GotJson (Result Http.Error String)
    | ExpandAll
    | CollapseSome
    | InputSome String


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
            , someString = "4"
            , some = 4
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
                | state = JsonTree.collapseToDepth model.some model.tree model.state
            }
                |> withNoCmd

        -- TODO
        InputSome someString ->
            let
                m =
                    { model | someString = someString }
            in
            case String.toInt someString of
                Nothing ->
                    m |> withNoCmd

                Just some ->
                    { m | some = some }
                        |> withNoCmd

        _ ->
            model |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []

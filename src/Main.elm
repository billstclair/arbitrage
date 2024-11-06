--------------------------------------------------------------------
--
-- Main.elm
-- Arbitrage top-level
-- Copyright (c) 2024 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


port module Main exposing (main)

import Arbitrage.Arbitrage as Arbitrage
import Arbitrage.Types exposing (Coin, Price, Trader)
import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation exposing (Key)
import Char
import Cmd.Extra exposing (withCmd, withCmds, withNoCmd)
import Dict exposing (Dict)
import Html exposing (Attribute, Html, a, h2, node, p, text)
import Html.Attributes as Attributes exposing (href, style)
import Html.Events exposing (keyCode, on)
import Json.Decode as JD exposing (Decoder, Value)
import Json.Encode as JE
import Task
import Url exposing (Url)


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


center : List (Attribute msg) -> List (Html msg) -> Html msg
center =
    node "center"


b : String -> Html msg
b s =
    text s


view : Model -> Document Msg
view model =
    { title = "Arbitrage"
    , body =
        [ center []
            [ h2 []
                [ text "Arbitrage" ]
            , p [] []
            , p [] [ text "Future home of Arbitrage.wtf" ]
            , p [] [ text "Automated Crypto Arbitrage trading" ]
            , p [] [ text "Eventually sports arbitrage betting." ]
            , p []
                [ b "GitHub: "
                , a
                    [ href "https://github.com/billstclair/arbitrage" ]
                    [ text "github.com/billstclair.com/arbitrage" ]
                ]
            , p []
                [ a [ href "https://github.com/billstclair/arbitrage/blob/main/manifesto.md" ]
                    [ text "Manifesto" ]
                ]
            , p []
                [ a [ href "./LICENSE" ]
                    [ text "LICENSE" ]
                ]
            , p []
                [ a [ href "docs.html" ]
                    [ text "Etherium JSON-RPC docs" ]
                ]
            ]
        ]
    }


type alias Model =
    { traders : List Trader
    }


type Msg
    = Noop
    | OnUrlRequest UrlRequest
    | OnUrlChange Url


init : Value -> url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model : Model
        model =
            { traders = []
            }
    in
    model |> withNoCmd


{-| This is used by links created by Util.toVirtualDom calls below.

It forces them to open in a new tab/window.

-}
port openWindow : Value -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            model |> withNoCmd

        OnUrlRequest urlRequest ->
            case Debug.log "OnUrlRequest" urlRequest of
                External url ->
                    model |> withCmd (openWindow <| JE.string url)

                Internal url ->
                    model |> withCmd (openWindow <| JE.string (Url.toString url))

        OnUrlChange url ->
            let
                url2 =
                    Debug.log "OnUrlChange" url
            in
            case url2.fragment of
                Nothing ->
                    model |> withNoCmd

                Just fragment ->
                    model |> withCmd (openWindow <| JE.string ("#" ++ fragment))


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []

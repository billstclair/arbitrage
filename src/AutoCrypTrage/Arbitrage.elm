---------------------------------------------------------------------
--
-- Arbitrage.elm
-- Calculate Arbitrage
-- Copyright (c) 2024 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module AutoCrypTrage.Arbitrage exposing (findArbitrage, nextTrade)

import AutoCrypTrage.Types
    exposing
        ( Amount
        , BuyOrSell(..)
        , Coin
        , CoinID
        , Price
        , PriceDict
        , Quantity
        , ToCoinDict
        , Trade
        , TradeArm
        , TradeDict
        , TradeStack
        , Trader
        , TraderID
        , TraderPrices
        , WalletEntry
        )
import Dict exposing (Dict)
import Dict.Extra as DE


firstValue : Dict comparable y -> Maybe y
firstValue dict =
    case DE.find (\_ _ -> True) dict of
        Nothing ->
            Nothing

        Just ( k, v ) ->
            Just v


{-| Pull the next trade off of TradeStack.
The returned TradeStack has that Trade omitted.
-}
nextTrade : TradeStack -> ( Maybe Trade, TradeStack )
nextTrade stack =
    let
        coinid : CoinID
        coinid =
            stack.initialCoin.id
    in
    case firstValue stack.tradeDict of
        Nothing ->
            ( Nothing, stack )

        Just prices ->
            case Dict.get coinid prices.prices of
                Nothing ->
                    nextTrade
                        { stack
                            | tradeDict =
                                Dict.remove prices.trader.id stack.tradeDict
                        }

                Just toCoinDict ->
                    case getToTrade coinid toCoinDict of
                        ( Nothing, _ ) ->
                            nextTrade
                                { stack
                                    | tradeDict =
                                        Dict.remove prices.trader.id stack.tradeDict
                                }

                        ( Just trade, toCoinDict2 ) ->
                            let
                                prices2 =
                                    { prices
                                        | prices =
                                            Dict.insert coinid
                                                toCoinDict2
                                                prices.prices
                                    }
                            in
                            ( Just trade
                            , { stack
                                | tradeDict =
                                    Dict.insert prices.trader.id prices2 stack.tradeDict
                              }
                            )


getToTrade : CoinID -> ToCoinDict -> ( Maybe Trade, ToCoinDict )
getToTrade coinsid toCoinDict =
    -- TODO
    ( Nothing, toCoinDict )


{-| If the first return value is not `Nothing`, it will be pushed
onto the `trades` in the `TradeStack`.

This means you can call `findArbitrage` over and over with the
returned `TradeStack`, and it will return arbitrages until the first
return value is Nothing. Then all of them will be in the
`TradeStack`'s `trades` property.

-}
findArbitrage : TradeStack -> ( Maybe Trade, TradeStack )
findArbitrage stack =
    -- TODO
    ( Nothing, stack )

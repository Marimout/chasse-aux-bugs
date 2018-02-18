module Main exposing (..)

import App.Messages exposing (Msg)
import App.Model exposing (Model, init)
import App.Subscriptions exposing (subscriptions)
import App.Update exposing (update)
import App.View exposing (view)
import Html exposing (Html)


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }

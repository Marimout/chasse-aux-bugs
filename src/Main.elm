module Main exposing (main)

import App.Messages exposing (Msg)
import App.Model exposing (BlocklyData, Level, Model, Page(..))
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


init : ( Model, Cmd Msg )
init =
    let
        inputBlockly =
            BlocklyData "" "" ""

        outputBlockly =
            BlocklyData "" "" ""

        level =
            Level 1 (List.singleton "") ""

        page =
            Login

        model =
            { team = ""
            , level = level
            , page = page
            , inputBlockly = inputBlockly
            , outputBlockly = outputBlockly
            , inputRows = List.singleton ""
            , outputRows = List.singleton ""
            }
    in
    ( model, Cmd.none )

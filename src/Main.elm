module Main exposing (main)

import App.Messages exposing (Msg, Msg(LevelUp))
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

        page =
            Login

        model =
            { team = ""
            , lvlNb = 0
            , level = Nothing
            , page = page
            , inputBlockly = inputBlockly
            , outputBlockly = outputBlockly
            , outputRows = List.singleton ""
            , errorMessage = ""
            }
    in
        update LevelUp model
    -- ( model, Cmd.map (always LevelUp) Cmd.none )

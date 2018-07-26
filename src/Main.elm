port module Main exposing (..)

import App.Messages exposing (Msg(LevelUp))
import App.Model exposing (BlocklyData, InputSet, Model, Page(..))
import App.Subscriptions exposing (subscriptions)
import App.Update exposing (update)
import App.View exposing (view)
import Html exposing (Html)
import Utils exposing (defaultCsv)


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

        inputSet =
            InputSet 0 defaultCsv defaultCsv

        model =
            { team = ""
            , lvlNb = 0
            , level = Nothing
            , currentInputSet = inputSet
            , inputGlobalSheet = defaultCsv
            , page = page
            , inputBlockly = inputBlockly
            , outputBlockly = outputBlockly
            , outputRows = []
            , errorMessage = ""
            , databaseData = defaultCsv
            , queryToExecute = ""
            , queryResult = ""
            }
    in
        update LevelUp model

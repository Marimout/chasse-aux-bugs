module App.Pages.Process exposing (processView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (BlocklyData, Model, Page(Overview))
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


processView : Model -> BlocklyData -> Html Msg
processView model blocklyData =
    div [ class "ui two column grid" ]
        [ div [ class "stretched row" ]
            [ div [ class "column" ]
                [ div [ class "ui segment" ] [ getBlocklyWorkspace blocklyData ] ]
            , div [ class "column" ]
                [ div [ class "ui segment" ] [ getInputTable model.currentInputSet.inputCsv ]
                , div [ class "ui segment" ] [ getOutputTable ]
                ]
            ]
        ]


getBlocklyWorkspace : BlocklyData -> Html Msg
getBlocklyWorkspace data =
    text "Blockly Workspace"


getInputTable : Csv -> Html Msg
getInputTable inputCsv =
    text "Input Table"


getOutputTable : Html Msg
getOutputTable =
    text "Output Table"

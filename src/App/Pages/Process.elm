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
                [ div [ class "ui green segment" ]
                    [ h3 [ class "ui header" ] [ text "données en entrée" ]
                    , getInputTable model.currentInputSet.inputCsv
                    ]
                , div [ class "ui yellow segment" ]
                    [ h3 [ class "ui header" ] [ text "résultat du traitement" ]
                    , getResultTable model.currentInputSet.resultCsv
                    ]
                ]
            ]
        ]


getBlocklyWorkspace : BlocklyData -> Html Msg
getBlocklyWorkspace data =
    text "Blockly Workspace"


getInputTable : Csv -> Html Msg
getInputTable inputCsv =
    table [ class "ui selectable celled table" ]
        [ thead []
            [ List.map (\h -> th [] [ text h ]) inputCsv.headers
                |> tr []
            ]
        , tbody []
            (inputCsv.records
                |> List.map
                    (\r ->
                        List.map (\v -> td [] [ text v ]) r
                            |> tr []
                    )
            )
        ]


getResultTable : Csv -> Html Msg
getResultTable resultCsv =
    table [ class "ui inverted celled table" ]
        [ thead []
            [ List.map (\h -> th [] [ text h ]) resultCsv.headers
                |> tr []
            ]
        , tbody []
            (resultCsv.records
                |> List.map
                    (\r ->
                        List.map (\v -> td [] [ text v ]) r
                            |> tr []
                    )
            )
        ]

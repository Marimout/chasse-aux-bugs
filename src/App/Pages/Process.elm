module App.Pages.Process exposing (processView)

import App.Messages exposing (Msg(ChangePage, EditInputSetCsv))
import App.Model exposing (BlocklyData, Model, Page(Overview), TableCell)
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
import Utils exposing (onTableCellInput, getInvertedTable)


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
                    , getInvertedTable model.currentInputSet.resultCsv
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
                |> List.indexedMap
                    (\i row ->
                        List.indexedMap
                            (\j val ->
                                td []
                                    [ div [ class "ui fluid transparent input" ]
                                        [ input
                                            [ type_ "text"
                                            , value val
                                            , attribute "data-row" (toString i)
                                            , attribute "data-col" (toString j)
                                            , onTableCellInput EditInputSetCsv
                                            ]
                                            []
                                        ]
                                    ]
                            )
                            row
                            |> tr []
                    )
            )
        ]

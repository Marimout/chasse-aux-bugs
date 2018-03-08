module App.Pages.Process exposing (processView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (BlocklyData, Model, Page(Overview))
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


processView : Model -> BlocklyData -> Html Msg
processView model blocklyData =
    let
        inputSetCsv =
            case model.level of
                Just level ->
                    getInputSetCsv model.currentInputSet.number level.inputRowsBySheet model.inputGlobalSheet

                Nothing ->
                    { headers = [], records = [] }
    in
    div [ class "ui two column grid" ]
        [ div [ class "stretched row" ]
            [ div [ class "column" ]
                [ div [ class "ui segment" ] [ getBlocklyWorkspace blocklyData ] ]
            , div [ class "column" ]
                [ div [ class "ui segment" ] [ getInputTable inputSetCsv ]
                , div [ class "ui segment" ] [ getOutputTable ]
                ]
            ]
        ]



-- TODO: refactor!


getInputSetCsv : Int -> List Int -> Csv -> Csv
getInputSetCsv currentSet rowsBySheet globalSheet =
    let
        records =
            globalSheet.records
                |> List.drop (List.sum <| List.take currentSet rowsBySheet)
                |> List.take (Maybe.withDefault 0 <| List.head <| List.drop currentSet rowsBySheet)
    in
    { headers = globalSheet.headers, records = records }


getBlocklyWorkspace : BlocklyData -> Html Msg
getBlocklyWorkspace data =
    text "Blockly Workspace"


getInputTable : Csv -> Html Msg
getInputTable inputCsv =
    text "Input Table"


getOutputTable : Html Msg
getOutputTable =
    text "Output Table"



-- h2 [ class "ui center aligned header" ] [ text "Process Page" ]
-- , p [] [ text ("Toolbox: " ++ blocklyData.toolbox) ]
-- , p [] [ text ("Workspace: " ++ blocklyData.workspace) ]
-- , p [] [ text ("Script: " ++ blocklyData.script) ]
-- ]

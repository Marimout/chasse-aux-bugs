module Utils exposing ((=>), defaultCsv, onTableCellInput, pair, viewIf, getStandardTable, getInvertedTable)

import App.Messages exposing (Msg)
import App.Model exposing (TableCell)
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on)
import Json.Decode as Json


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


pair : a -> b -> ( a, b )
pair first second =
    first => second


viewIf : Bool -> Html msg -> Html msg
viewIf condition content =
    if condition then
        content
    else
        Html.text ""


defaultCsv : Csv
defaultCsv =
    { headers = [], records = [] }


onTableCellInput : (TableCell -> Msg) -> Attribute Msg
onTableCellInput tagger =
    on "input" (Json.map tagger tableCellInputDecoder)


tableCellInputDecoder : Json.Decoder TableCell
tableCellInputDecoder =
    Json.map4 TableCell
        (Json.at [ "target", "value" ] Json.string)
        (Json.at [ "target", "dataset", "row" ] Json.string |> jsonStringToIntDecoder)
        (Json.at [ "target", "dataset", "col" ] Json.string |> jsonStringToIntDecoder)
        (Json.at [ "target", "dataset", "fieldname" ] Json.string)


jsonStringToIntDecoder : Json.Decoder String -> Json.Decoder Int
jsonStringToIntDecoder =
    Json.map (\str -> String.toInt str |> Result.withDefault 0)


getTable : ( String, Csv ) -> Html Msg
getTable ( tableStyle, csv ) =
    table [ class tableStyle ]
        [ thead []
            [ List.map (\h -> th [] [ text h ]) csv.headers
                |> tr []
            ]
        , tbody []
            (csv.records
                |> List.map
                    (\r ->
                        List.map (\v -> td [] [ text v ]) r
                            |> tr []
                    )
            )
        ]


getInvertedTable : Csv -> Html Msg
getInvertedTable csv =
    getTable ( "ui inverted celled table", csv )


getStandardTable : Csv -> Html Msg
getStandardTable csv =
    getTable ( "ui celled table", csv )

module Utils exposing ((=>), defaultCsv, pair, viewIf, getStandardTable, getInvertedTable, fullHeight)

import App.Messages exposing (Msg)
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
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


fullHeight : Attribute msg
fullHeight =
    style [ ( "height", "100%" ) ]


defaultCsv : Csv
defaultCsv =
    { headers = [], records = [] }


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

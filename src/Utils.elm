module Utils exposing ((=>), defaultCsv, pair, viewIf)

import Csv exposing (Csv)
import Html exposing (Html)


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

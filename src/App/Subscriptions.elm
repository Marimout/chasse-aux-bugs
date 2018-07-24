port module App.Subscriptions exposing (subscriptions)

import App.Messages exposing (..)
import App.Model exposing (Model)
import Json.Encode exposing (..)


port loadDataFromDatabase : (Json.Encode.Value -> msg) -> Sub msg


port blocklyCodeChange : (String -> msg) -> Sub msg


port blocklyEvalResult : (Json.Encode.Value -> msg) -> Sub msg


port updateQueryExecutionResult : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    -- always Sub.none model
    Sub.batch
        [ loadDataFromDatabase LoadDataFromDatabase
        , updateQueryExecutionResult UpdateQueryResult
        , blocklyCodeChange EvalBlocklyCode
        ]

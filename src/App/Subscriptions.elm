port module App.Subscriptions exposing (subscriptions)

import App.Messages exposing (..)
import App.Model exposing (Model)


port loadDataFromDatabase : (String -> msg) -> Sub msg


port blocklyCodeChange : (String -> msg) -> Sub msg


port blocklyEvalResult : (String -> msg) -> Sub msg


port updateQueryExecutionResult : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loadDataFromDatabase LoadDataFromDatabase
        , updateQueryExecutionResult UpdateQueryResult
        , blocklyCodeChange EvalBlocklyCode
        ]

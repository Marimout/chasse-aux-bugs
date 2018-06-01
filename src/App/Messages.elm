module App.Messages exposing (Msg(..))

import App.Model exposing (LevelInfos, Page, TableCell)
import Http exposing (..)
import Json.Encode


type Msg
    = NoOp
    | TeamName String
    | ChangePage Page
    | ChangeInputSet Int
    | EditInputSetCsv TableCell
    | ComputeInputSetResult
    | LevelUp
    | LevelInfosResult (Result Http.Error LevelInfos)
    | InputCsvResult (Result Http.Error String)
    | LoadDataFromDatabase Json.Encode.Value
    | UpdateSqlQuery String
    | ExecuteQuery
    | UpdateQueryResult String
    | EditDatabaseRecord TableCell
    | SaveModifiedData

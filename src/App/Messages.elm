module App.Messages exposing (Msg(..))

import App.Model exposing (BlocklyData, LevelInfos, Page, TableCell)
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
    | LoadInputCsv
    | InputCsvResult (Result Http.Error String)
    | LoadDataFromDatabase Json.Encode.Value
    | LoadBlocklyToolbox String
    | BlocklyToolboxResult String (Result Http.Error String)
    | UpdateSqlQuery String
    | ExecuteQuery
    | UpdateQueryResult String
    | EditDatabaseRecord TableCell
    | SaveModifiedData

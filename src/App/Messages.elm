module App.Messages exposing (Msg(..))

import App.Model exposing (BlocklyData, LevelInfos, Page, TableCell)
import Http exposing (..)


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
    | LoadDataFromDatabase String
    | LoadBlocklyToolbox String
    | BlocklyToolboxResult String (Result Http.Error String)
    | UpdateSqlQuery String
    | ExecuteQuery
    | UpdateQueryResult String
    | EditDatabaseRecord TableCell
    | EvalBlocklyCode String

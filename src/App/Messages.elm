module App.Messages exposing (Msg(..))

import App.Model exposing (LevelInfos, Page)
import Http exposing (..)
import Json.Encode


type Msg
    = NoOp
    | TeamName String
    | ChangePage Page
    | ChangeInputSet Int
    | ComputeInputSetResult
    | LoadData Json.Encode.Value
    | LevelUp
    | LevelInfosResult (Result Http.Error LevelInfos)
    | InputCsvResult (Result Http.Error String)

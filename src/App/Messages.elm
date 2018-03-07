module App.Messages exposing (Msg(..))

import App.Model exposing (LevelInfos, Page)
import Http exposing (..)


type Msg
    = NoOp
    | TeamName String
    | ChangePage Page
    | ChangeInputSet Int
    | LevelUp
    | LevelInfosResult (Result Http.Error LevelInfos)
    | InputCsvResult (Result Http.Error String)

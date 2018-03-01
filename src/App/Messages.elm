module App.Messages exposing (Msg(..))

import Http exposing (..)
import App.Model exposing (Page, LevelInfosJson)


type Msg
    = NoOp
    | TeamName String
    | ChangePage Page
    | LevelUp
    | LevelInfosResult (Result Http.Error LevelInfosJson)
    | InputCsvResult (Result Http.Error String)

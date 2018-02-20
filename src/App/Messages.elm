module App.Messages exposing (Msg(..))

import App.Model exposing (Page)


type Msg
    = NoOp
    | TeamName String
    | ChangePage Page

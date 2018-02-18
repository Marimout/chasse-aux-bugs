module App.Model exposing (Model, init)

import App.Messages exposing (Msg)


type alias Model =
    { team : String
    , lvl : Int
    , inputBlockly : BlocklyData
    , outputBlockly : BlocklyData
    , inputRows : List String
    , outputRows : List String
    }


type alias BlocklyData =
    { toolbox : String
    , workspace : String
    , script : String
    }


init : ( Model, Cmd Msg )
init =
    let
        inputBlockly =
            BlocklyData "" "" ""

        outputBlockly =
            BlocklyData "" "" ""

        model =
            { team = ""
            , lvl = 1
            , inputBlockly = inputBlockly
            , outputBlockly = outputBlockly
            , inputRows = List.singleton ""
            , outputRows = List.singleton ""
            }
    in
    ( model, Cmd.none )

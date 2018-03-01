module App.Model exposing (Model, BlocklyData, Level, LevelInfosJson, Page(..))

import Csv exposing (Csv)


type alias Model =
    { team : String
    , lvlNb : Int 
    , level : Maybe Level
    , page : Page
    , inputBlockly : BlocklyData
    , outputBlockly : BlocklyData
    , outputRows : List String
    , errorMessage : String
    }


type Page
    = Login
    | Overview
    | InputForm
    | InputProcess
    | Database
    | OutputProcess
    | Output


type alias BlocklyData =
    { toolbox : String
    , workspace : String
    , script : String
    }


type alias Level =
    { inputSheets : List Csv
    , expectedOutput : String
    , texts : List String
    }


type alias LevelInfosJson =
    { version : String
    , number : Int
    , availableTools : List String
    , inputRowsBySheet : List Int
    }
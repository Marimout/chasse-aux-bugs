module App.Model exposing (BlocklyData, InputSet, LevelInfos, Model, Page(..), TableCell)

import Csv exposing (Csv)


type alias Model =
    { team : String
    , page : Page
    , lvlNb : Int
    , currentInputSet : InputSet
    , level : Maybe LevelInfos
    , inputGlobalSheet : Csv
    , inputBlockly : BlocklyData
    , outputBlockly : BlocklyData
    , outputRows : List String
    , errorMessage : String
    , databaseData : Csv
    , queryToExecute : String
    , queryResult : String
    }


type Page
    = Login
    | Overview
    | InputForm
    | InputProcess
    | Database
    | OutputProcess
    | Output


type alias InputSet =
    { number : Int
    , inputCsv : Csv
    , resultCsv : Csv
    }


type alias TableCell =
    { value : String
    , row : Int
    , col : Int

    --, fieldName : String
    }


type alias BlocklyData =
    { toolbox : String
    , workspace : String
    , script : String
    }


type alias LevelInfos =
    { version : String
    , number : Int
    , availableTools : List String
    , inputRowsBySheet : List Int
    , expectedOutput : String
    , texts : List String
    }

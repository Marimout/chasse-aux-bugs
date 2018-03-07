module App.Model exposing (BlocklyData, LevelInfos, Model, Record, Page(..))

import Csv exposing (Csv)


type alias Model =
    { team : String
    , page : Page
    , lvlNb : Int
    , currentInputSet : Int
    , level : Maybe LevelInfos
    , inputGlobalSheet : Maybe Csv
    , inputBlockly : BlocklyData
    , outputBlockly : BlocklyData
    , outputRows : List String
    , errorMessage : String
    , data : Maybe (List Record)
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


type alias LevelInfos =
    { version : String
    , number : Int
    , availableTools : List String
    , inputRowsBySheet : List Int
    , expectedOutput : String
    , texts : List String
    }

type alias Record = 
    { id : Int
    , date : String
    , libelle : String
    , montant : String
    , devise : String
    }
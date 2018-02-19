module App.Model exposing (BlocklyData, Level, Model, Page(..))


type alias Model =
    { team : String
    , level : Level
    , page : Page
    , inputBlockly : BlocklyData
    , outputBlockly : BlocklyData
    , inputRows : List String
    , outputRows : List String
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
    { number : Int
    , testInputs : List String
    , expectedOutput : String
    }

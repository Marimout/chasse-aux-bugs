module App.Update exposing (update)

import Csv
import Http exposing (..)
import Json.Decode as Decode exposing (field, Decoder)
import App.Messages exposing (Msg(..))
import App.Model exposing (Model, LevelInfosJson)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
            
        TeamName teamName ->
            ( { model | team = teamName }, Cmd.none )

        ChangePage newPage ->
            ( { model | page = newPage }, Cmd.none )

        LevelUp ->
            let
                newLvlNb = model.lvlNb + 1
                
                --newLevelInfos = getLevelInfos newLvlNb
                
                --newLevel =
                --    { inputSheets = loadInputSheets
                --    , expectedOutput = ""
                --    , texts = List.singleton ""
                --    }
                cmd = 
                    Http.send LevelInfosResult <|
                        Http.get ( (getLevelDir newLvlNb) ++ "/infos.json" ) decodeLevelInfosJson
            in
                ( { model
                | lvlNb = newLvlNb
                }, cmd )
        
        LevelInfosResult (Ok lvlInfos) ->
            let
                cmd =
                    Http.send InputCsvResult <|
                        Http.getString ( (getLevelDir lvlInfos.number) ++ "/input.csv" )
            in
                ( model, cmd )
        
        LevelInfosResult (Err err) ->
            ( { model | errorMessage = toString err }, Cmd.none ) -- TODO
        
        InputCsvResult (Ok inputCsv) ->
            ( model, Cmd.none ) -- TODO
        
        InputCsvResult (Err err) ->
            ( model, Cmd.none ) -- TODO


getLevelDir : Int -> String
getLevelDir lvlNb =
    "./levels/" ++ (toString lvlNb) ++ "/"


--getLevelInfos : Int -> Http.Request LevelInfos
--getLevelInfos lvlNb =
--  Http.get ( (getLevelDir lvlNb) ++ "/infos.json" ) decodeLevelInfos


decodeLevelInfosJson : Decoder LevelInfosJson
decodeLevelInfosJson =
  Decode.map4 LevelInfosJson
    (field "version" Decode.string)
    (field "number" Decode.int)
    (field "availableTools" (Decode.list Decode.string))
    (field "inputRowsBySheet" (Decode.list Decode.int))


-- paseInputCsv : String -> Csv.Csv
-- paseInputCsv lvlNb =
    
module App.Update exposing (update)

import App.Messages exposing (Msg(..))
import App.Model exposing (LevelInfos, Model)
import Csv
import Http exposing (..)
import Json.Decode as Decode exposing (Decoder, field)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        TeamName teamName ->
            ( { model | team = teamName }, Cmd.none )

        ChangePage newPage ->
            ( { model | page = newPage }, Cmd.none )

        ChangeInputSet newInputSet ->
            ( { model | currentInputSet = newInputSet }, Cmd.none )

        LevelUp ->
            let
                newLvlNb =
                    model.lvlNb + 1

                cmd =
                    Http.send LevelInfosResult <|
                        Http.get (getLevelDir newLvlNb ++ "/infos.json") decodeLevelInfos
            in
            ( { model
                | lvlNb = newLvlNb
              }
            , cmd
            )

        LevelInfosResult result ->
            case result of
                Ok lvlInfos ->
                    let
                        cmd =
                            Http.send InputCsvResult <|
                                Http.getString (getLevelDir lvlInfos.number ++ "/inputs.csv")
                    in
                    ( { model | level = Just lvlInfos }, cmd )

                Err error ->
                    ( { model | errorMessage = toString error }, Cmd.none )

        InputCsvResult result ->
            case result of
                Ok inputCsv ->
                    ( { model | inputGlobalSheet = Just <| Csv.parse inputCsv }, Cmd.none )

                Err error ->
                    ( { model | errorMessage = toString error }, Cmd.none )


getLevelDir : Int -> String
getLevelDir lvlNb =
    "./levels/" ++ toString lvlNb ++ "/"


decodeLevelInfos : Decoder LevelInfos
decodeLevelInfos =
    Decode.map6 LevelInfos
        (field "version" Decode.string)
        (field "number" Decode.int)
        (field "availableTools" (Decode.list Decode.string))
        (field "inputRowsBySheet" (Decode.list Decode.int))
        (field "expectedOutput" Decode.string)
        (field "texts" (Decode.list Decode.string))

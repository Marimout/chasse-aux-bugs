port module App.Update exposing (update)

import App.Messages exposing (Msg(..))
import App.Model exposing (InputSet, LevelInfos, Model, Record, TableCell)
import Csv exposing (Csv)
import Http exposing (..)
import Json.Decode as Decode exposing (Decoder, field)
import Utils exposing (defaultCsv)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        TeamName teamName ->
            ( { model | team = teamName }, Cmd.none )

        ChangePage newPage ->
            ( { model | page = newPage }, Cmd.none )

        ChangeInputSet newInputSetNb ->
            update ComputeInputSetResult { model | currentInputSet = getInputSet newInputSetNb model }

        EditInputSetCsv tableCell ->
            let
                oldInputSet =
                    model.currentInputSet

                newInputSet =
                    { oldInputSet | inputCsv = getUpdatedInputCsv tableCell oldInputSet.inputCsv }
            in
            update ComputeInputSetResult { model | currentInputSet = newInputSet }

        ComputeInputSetResult ->
            let
                result =
                    model.currentInputSet.inputCsv

                oldInputSet =
                    model.currentInputSet

                newInputSet =
                    { oldInputSet | resultCsv = result }
            in
            ( { model | currentInputSet = newInputSet }, Cmd.none )

        LevelUp ->
            let
                newLvlNb =
                    model.lvlNb + 1

                cmd =
                    Http.get (getLevelDir newLvlNb ++ "/infos.json") decodeLevelInfos
                        |> Http.send LevelInfosResult
            in
            ( { model | lvlNb = newLvlNb }, cmd )

        LevelInfosResult result ->
            case result of
                Ok lvlInfos ->
                    let
                        cmd =
                            Http.getString (getLevelDir lvlInfos.number ++ "/inputs.csv")
                                |> Http.send InputCsvResult
                    in
                    ( { model | level = Just lvlInfos }, cmd )

                Err error ->
                    ( { model | errorMessage = toString error }, Cmd.none )

        InputCsvResult result ->
            case result of
                Ok inputCsv ->
                    update (ChangeInputSet model.currentInputSet.number) { model | inputGlobalSheet = Csv.parse inputCsv }

                Err error ->
                    ( { model | errorMessage = toString error, inputGlobalSheet = defaultCsv }, Cmd.none )

        LoadDataFromDatabase newData ->
            let
                t =
                    Decode.decodeValue (Decode.list decodeRecord) newData
            in
            case t of
                Ok record ->
                    ( { model | data = Just record }, Cmd.none )

                Err error ->
                    ( { model | data = Nothing }, Cmd.none )

        UpdateSqlQuery query ->
            ( { model | queryToExecute = query }, Cmd.none )

        ExecuteQuery ->
            ( model, executeQuery model.queryToExecute )

        UpdateQueryResult result ->
            ( { model | queryResult = result }, Cmd.none )


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


decodeRecord : Decoder Record
decodeRecord =
    Decode.map5 Record
        (field "id" Decode.int)
        (field "date" Decode.string)
        (field "libelle" Decode.string)
        (field "montant" Decode.string)
        (field "devise" Decode.string)


getInputSet : Int -> Model -> InputSet
getInputSet number model =
    let
        rowsBySheet =
            case model.level of
                Just level ->
                    level.inputRowsBySheet

                Nothing ->
                    List.singleton <| List.length model.inputGlobalSheet.records

        inputRecords =
            model.inputGlobalSheet.records
                |> List.drop (List.sum <| List.take number rowsBySheet)
                |> List.take (Maybe.withDefault 0 <| List.head <| List.drop number rowsBySheet)
    in
    { number = number
    , inputCsv = Csv model.inputGlobalSheet.headers inputRecords
    , resultCsv = defaultCsv
    }


getUpdatedInputCsv : TableCell -> Csv -> Csv
getUpdatedInputCsv tableCell inputCsv =
    let
        records =
            inputCsv.records
                |> List.indexedMap
                    (\i row ->
                        if i == tableCell.row then
                            row
                                |> List.indexedMap
                                    (\j val ->
                                        if j == tableCell.col then
                                            tableCell.value
                                        else
                                            val
                                    )
                        else
                            row
                    )
    in
    { inputCsv | records = records }


port executeQuery : String -> Cmd msg

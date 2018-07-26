port module App.Update exposing (update)

import App.Messages exposing (Msg(..))
import App.Model exposing (InputSet, LevelInfos, Model, TableCell, Page(..))
import Csv exposing (Csv)
import Http exposing (..)
import Json.Decode as Decode exposing (Decoder, field)
import Utils exposing (defaultCsv)


port executeQuery : String -> Cmd msg


port updateTableFromData : Csv -> Cmd msg


port injectBlockly : ( String, String ) -> Cmd msg


port evalBlockly : ( String, Csv ) -> Cmd msg


port removeBlockly : () -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        TeamName teamName ->
            ( { model | team = teamName }, Cmd.none )

        ChangePage newPage ->
            case newPage of
                InputProcess ->
                    ( { model | page = newPage }, injectBlockly ( "blocklyWorkspace", model.inputBlockly.toolbox ) )

                OutputProcess ->
                    ( { model | page = newPage }, injectBlockly ( "blocklyWorkspace", model.outputBlockly.toolbox ) )

                Overview ->
                    ( { model | page = newPage }, removeBlockly () )

                _ ->
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
                    update LoadInputCsv { model | level = Just lvlInfos }

                Err error ->
                    ( { model | errorMessage = toString error }, Cmd.none )

        LoadInputCsv ->
            case model.level of
                Just lvlInfos ->
                    ( model, Http.getString (getLevelDir lvlInfos.number ++ "/inputs.csv") |> Http.send InputCsvResult )

                Nothing ->
                    update NoOp model

        InputCsvResult result ->
            case result of
                Ok inputCsv ->
                    let
                        ( newModel, newCmd ) =
                            update (ChangeInputSet model.currentInputSet.number) { model | inputGlobalSheet = Csv.parse inputCsv }
                    in
                        if newCmd == Cmd.none then
                            update (LoadBlocklyToolbox "input") newModel
                        else
                            ( newModel, newCmd )

                Err error ->
                    ( { model | errorMessage = toString error, inputGlobalSheet = defaultCsv }, Cmd.none )

        LoadBlocklyToolbox toolboxType ->
            case model.level of
                Just lvlInfos ->
                    ( model
                    , Http.getString
                        (getLevelDir lvlInfos.number ++ "/blockly-toolbox-" ++ toolboxType ++ ".xml")
                        |> Http.send (BlocklyToolboxResult toolboxType)
                    )

                Nothing ->
                    update NoOp model

        BlocklyToolboxResult toolboxType result ->
            case result of
                Ok toolbox ->
                    if toolboxType == "input" then
                        let
                            oldBlocklyData =
                                model.inputBlockly

                            newBlocklyData =
                                { oldBlocklyData | toolbox = toolbox }
                        in
                            update (LoadBlocklyToolbox "output") { model | inputBlockly = newBlocklyData }
                    else
                        let
                            oldBlocklyData =
                                model.outputBlockly

                            newBlocklyData =
                                { oldBlocklyData | toolbox = toolbox }
                        in
                            ( { model | outputBlockly = newBlocklyData }, Cmd.none )

                Err error ->
                    ( { model | errorMessage = toString error }, Cmd.none )

        LoadDataFromDatabase newData ->
            ( { model | databaseData = Csv.parse newData }, Cmd.none )

        EditDatabaseRecord tableCell ->
            let
                newData =
                    getUpdatedCsv tableCell model.databaseData
            in
                ( model, updateTableFromData newData )

        UpdateSqlQuery query ->
            ( { model | queryToExecute = query }, Cmd.none )

        ExecuteQuery ->
            ( model, executeQuery model.queryToExecute )

        UpdateQueryResult result ->
            ( { model | queryResult = result }, Cmd.none )

        EvalBlocklyCode code ->
            case model.page of
                InputProcess ->
                    let
                        inputBlockly =
                            model.inputBlockly

                        updatedBlockly =
                            { inputBlockly | script = code }
                    in
                        ( { model | inputBlockly = updatedBlockly }, evalBlockly ( code, model.databaseData ) )

                OutputProcess ->
                    let
                        outputBlockly =
                            model.outputBlockly

                        updatedBlockly =
                            { outputBlockly | script = code }
                    in
                        ( { model | outputBlockly = updatedBlockly }, evalBlockly ( code, model.databaseData ) )

                _ ->
                    ( model, Cmd.none )


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


getUpdatedCsv : TableCell -> Csv -> Csv
getUpdatedCsv tableCell inputCsv =
    let
        cellMap row col val =
            if tableCell.row == row && tableCell.col == col then
                tableCell.value
            else
                val

        newRecords =
            List.indexedMap (\i r -> List.indexedMap (cellMap i) r) inputCsv.records
    in
        Csv inputCsv.headers newRecords

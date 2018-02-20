module App.Update exposing (update)

import App.Messages exposing (Msg(..))
import App.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TeamName teamName ->
            ( { model | team = teamName }, Cmd.none )

        ChangePage newPage ->
            ( { model | page = newPage }, Cmd.none )

        _ ->
            ( model, Cmd.none )

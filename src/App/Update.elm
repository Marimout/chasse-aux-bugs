module App.Update exposing (update)

import App.Messages exposing (Msg)
import App.Model exposing (Model)


-- import Utils exposing (pair)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

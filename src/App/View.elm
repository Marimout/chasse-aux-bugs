module App.View exposing (view)

import App.Messages exposing (Msg)
import App.Model exposing (Model, Page(..))
import App.Pages.Database exposing (databaseView)
import App.Pages.InputForm exposing (inputFormView)
import App.Pages.Login exposing (loginView)
import App.Pages.Output exposing (outputView)
import App.Pages.Overview exposing (overviewView)
import App.Pages.Process exposing (processView)
import Html exposing (Html, div, h1, h3, img, text)
import Html.Attributes exposing (class)
import Utils exposing (viewIf)


view : Model -> Html Msg
view model =
    div []
        [ viewIf (not <| String.isEmpty model.errorMessage)
            (h3 [ class "ui block red header" ] [ text model.errorMessage ])
        , pageBody model
        ]


pageBody : Model -> Html Msg
pageBody model =
    case model.page of
        Login ->
            loginView (String.length model.team)

        Overview ->
            overviewView model

        InputForm ->
            inputFormView model

        InputProcess ->
            processView model model.inputBlockly

        Database ->
            databaseView model

        OutputProcess ->
            processView model model.outputBlockly

        Output ->
            outputView model

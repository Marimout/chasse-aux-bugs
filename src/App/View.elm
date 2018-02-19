module App.View exposing (view)

import App.Messages exposing (Msg)
import App.Model exposing (Model, Page(..))
import App.Pages.Login exposing (loginView)
import App.Pages.Overview exposing (overviewView)
import App.Pages.InputForm exposing (inputFormView)
import App.Pages.Process exposing (processView)
import App.Pages.Database exposing (databaseView)
import App.Pages.Output exposing (outputView)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)


view : Model -> Html Msg
view model =
    div []
        [ pageBody model ]


pageBody : Model -> Html Msg
pageBody model =
    case model.page of
        Login -> loginView model
        Overview -> overviewView model
        InputForm -> inputFormView model
        InputProcess -> processView model model.inputBlockly
        Database -> databaseView model
        OutputProcess -> processView model model.outputBlockly
        Output -> outputView model

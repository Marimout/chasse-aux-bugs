module App.Pages.InputForm exposing (inputFormView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


inputFormView : Model -> Html Msg
inputFormView model =
    div []
        [ h2 [ class "ui center aligned header" ] [ text "Input form Page" ]
        ]

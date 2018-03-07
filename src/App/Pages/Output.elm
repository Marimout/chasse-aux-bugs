module App.Pages.Output exposing (outputView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


outputView : Model -> Html Msg
outputView model =
    div []
        [ h2 [ class "ui center aligned header" ] [ text "Output Page" ]
        ]

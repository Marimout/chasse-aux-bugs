module App.Pages.Login exposing (loginView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Page(Overview))
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


loginView : Html Msg
loginView =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "La chasse aux bugs !" ]
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

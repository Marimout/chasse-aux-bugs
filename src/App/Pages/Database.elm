module App.Pages.Database exposing (databaseView)

import App.Messages exposing (Msg, Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (Html, div, h1, img, text, button)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


databaseView : Model -> Html Msg
databaseView model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Database Page" ]
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

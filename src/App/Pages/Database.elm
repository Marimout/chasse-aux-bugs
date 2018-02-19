module App.Pages.Database exposing (databaseView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


databaseView : Model -> Html Msg
databaseView model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Database Page" ]
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

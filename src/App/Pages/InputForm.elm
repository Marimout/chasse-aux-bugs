module App.Pages.InputForm exposing (inputFormView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


inputFormView : Model -> Html Msg
inputFormView model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Input form Page" ]
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

module App.Pages.Output exposing (outputView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


outputView : Model -> Html Msg
outputView model =
    div []
        [ img [ src "logo.svg" ] []
        , h1 [] [ text "Output Page" ]
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

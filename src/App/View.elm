module App.View exposing (view)

import App.Messages exposing (Msg)
import App.Model exposing (Model)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]

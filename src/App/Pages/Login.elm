module App.Pages.Login exposing (loginView)

import App.Messages exposing (Msg(TeamName, ChangePage, NoOp))
import App.Model exposing (Page(Overview))
import Utils exposing(viewIf)
import Html exposing (Html, button, div, h1, img, text, input, form)
import Html.Attributes exposing (src, placeholder, type_, value)
import Html.Events exposing (onSubmit, onInput)


loginView : Int -> Html Msg
loginView teamNameLength =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "La chasse aux bugs !" ]
        , form [ onSubmit ( if teamNameLength > 2 then ChangePage Overview else NoOp ) ] [
            input [ type_ "text", placeholder "Nom d'équipe", onInput TeamName ] []
            , viewIf (teamNameLength > 2) (input [ type_ "submit", value "valider" ] [])
            ]
        ]

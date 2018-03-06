module App.Pages.Login exposing (loginView)

import App.Messages exposing (Msg(ChangePage, NoOp, TeamName))
import App.Model exposing (Page(Overview))
import Html exposing (Html, button, div, form, h1, img, input, text)
import Html.Attributes exposing (placeholder, src, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Utils exposing (viewIf)


loginView : Int -> Html Msg
loginView teamNameLength =
    div []
        [ img [ src "logo.svg" ] []
        , h1 [] [ text "La chasse aux bugs !" ]
        , form
            [ onSubmit
                (if teamNameLength > 2 then
                    ChangePage Overview
                 else
                    NoOp
                )
            ]
            [ input [ type_ "text", placeholder "Nom d'équipe", onInput TeamName ] []
            , viewIf (teamNameLength > 2) (input [ type_ "submit", value "valider" ] [])
            ]
        ]

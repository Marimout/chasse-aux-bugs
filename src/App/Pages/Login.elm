module App.Pages.Login exposing (loginView)

import App.Messages exposing (Msg(ChangePage, NoOp, TeamName))
import App.Model exposing (Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Utils exposing (viewIf)


loginView : Int -> Html Msg
loginView teamNameLength =
    div [ class "ui center aligned segment" ]
        [ img [ src "logo.jpg", class "ui centered big image" ] []
        , Html.form
            [ class "ui form"
            , onSubmit
                (if teamNameLength > 2 then
                    ChangePage Overview
                 else
                    NoOp
                )
            ]
            [ br [] []
            , div [ class "inline field" ]
                [ label [] [ text "Nom d'équipe" ]
                , input [ type_ "text", placeholder "Nom d'équipe", onInput TeamName ] []
                ]
            , viewIf (teamNameLength > 2) (input [ class "ui button", type_ "submit", value "valider" ] [])
            ]
        ]

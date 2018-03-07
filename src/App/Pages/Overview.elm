module App.Pages.Overview exposing (overviewView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


overviewView : Model -> Html Msg
overviewView model =
    div []
        [ div [ class "ui grid" ]
            [ div [ class "eight wide column" ]
                [ div [ class "ui card centered" ]
                    [ div [ class "content" ]
                        [ div [ class "header" ] [ text "Données en entrées" ]
                        , div [ class "description" ] [ text "Les mouvements bancaires sont affichés ici" ]
                        ]
                    , div [ class "ui bottom attached button", onClick (ChangePage InputForm) ]
                        [ i [ class "file icon" ] []
                        , text "Go"
                        ]
                    ]
                ]
            , div [ class "eight wide column" ]
                [ div [ class "ui card centered" ]
                    [ div [ class "content" ]
                        [ div [ class "header" ] [ text "Programme de traitement des données d'entrée" ]
                        , div [ class "description" ] [ text "Le programme Blockly pour traiter les données d'entrée est affiché ici" ]
                        ]
                    , div [ class "ui bottom attached button", onClick (ChangePage InputProcess) ]
                        [ i [ class "code icon" ] []
                        , text "Go"
                        ]
                    ]
                ]
            , div [ class "sixteen wide column" ]
                [ div [ class "ui card centered" ]
                    [ div [ class "content" ]
                        [ div [ class "header" ] [ text "La base de données" ]
                        , div [ class "description" ] [ text "L'espace ou sont stocké toutes les données de l'application" ]
                        ]
                    , div [ class "ui bottom attached button", onClick (ChangePage Database) ]
                        [ i [ class "archive icon" ] []
                        , text "Go"
                        ]
                    ]
                ]
            , div [ class "eight wide column" ]
                [ div [ class "ui card centered" ]
                    [ div [ class "content" ]
                        [ div [ class "header" ] [ text "Programme de génération de relevé" ]
                        , div [ class "description" ] [ text "Le programme Blockly pour générer le relevé est affiché ici" ]
                        ]
                    , div [ class "ui bottom attached button", onClick (ChangePage OutputProcess) ]
                        [ i [ class "code icon" ] []
                        , text "Go"
                        ]
                    ]
                ]
            , div [ class "eight wide column" ]
                [ div [ class "ui card centered" ]
                    [ div [ class "content" ]
                        [ div [ class "header" ] [ text "La sortie" ]
                        , div [ class "description" ] [ text "Le relevé de compte s'affiche ici" ]
                        ]
                    , div [ class "ui bottom attached button", onClick (ChangePage Output) ]
                        [ i [ class "file icon" ] []
                        , text "Go"
                        ]
                    ]
                ]
            ]
        ]

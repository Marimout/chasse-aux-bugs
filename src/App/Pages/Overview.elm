module App.Pages.Overview exposing (overviewView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Button as Button
import Bootstrap.Utilities.Spacing as Spacing

overviewView : Model -> Html Msg
overviewView model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "BUGS BUSTER" ]
        , Grid.container [ ]
            [ Grid.row [ Row.attrs [ Spacing.my3 ] ]
                [ Grid.col []
                    [ Card.config [ Card.outlinePrimary ]
                        |> Card.headerH4 [] [ text "Données entrées" ]
                        |> Card.block []
                            [ Block.text [] [ text "Les mouvements bancaires sont affichés ici" ]
                            , Block.custom <|
                                Button.linkButton
                                    [ Button.primary, Button.attrs [ onClick (ChangePage InputForm) ] ]
                                    [ text "Start" ]
                            ]
                        |> Card.view
                    ]
                , Grid.col []
                    [ Card.config [ Card.outlinePrimary ]
                        |> Card.headerH4 [] [ text "Programme de traitement des données d'entrée" ]
                        |> Card.block []
                            [ Block.text [] [ text "Le programme Blockly pour traiter les données d'entrée est affiché ici" ]
                            , Block.custom <|
                                Button.linkButton
                                    [ Button.primary, Button.attrs [ onClick (ChangePage InputProcess) ] ]
                                    [ text "Start" ]
                            ]
                        |> Card.view
                    ]
                ]
            , Grid.row [ Row.attrs [ Spacing.my3 ] ]
                [ Grid.col []
                    [ Card.config [ Card.outlinePrimary ]
                        |> Card.headerH4 [] [ text "FIN" ]
                        |> Card.block []
                            [ Block.text [] [ text "T'es arrivé au bout du process ! Bravo !" ]
                            ]
                        |> Card.view
                    ]
                , Grid.col []
                    [ Card.config [ Card.outlinePrimary ]
                        |> Card.headerH4 [] [ text "Gestion de base de données" ]
                        |> Card.block []
                            [ Block.text [] [ text "Cliquez sur le bouton pour accéder au module de gestion de base de données" ]
                            , Block.custom <|
                                Button.linkButton
                                    [ Button.primary, Button.attrs [ onClick (ChangePage Database) ] ]
                                    [ text "Start" ]
                            ]
                        |> Card.view
                    ]
                ]
            , Grid.row [ Row.attrs [ Spacing.my3 ] ]
                [ Grid.col []
                    [ Card.config [ Card.outlinePrimary ]
                        |> Card.headerH4 [] [ text "La sortie" ]
                        |> Card.block []
                            [ Block.text [] [ text "Le relevé de compte s'affiche ici" ]
                            , Block.custom <|
                                Button.linkButton
                                    [ Button.primary, Button.attrs [ onClick (ChangePage Output) ] ]
                                    [ text "Start" ]
                            ]
                        |> Card.view
                    ]
                , Grid.col []
                    [ Card.config [ Card.outlinePrimary ]
                        |> Card.headerH4 [] [ text "Programme de génération de relevé" ]
                        |> Card.block []
                            [ Block.text [] [ text "Le programme Blockly pour générer le relevé est affiché ici" ]
                            , Block.custom <|
                                Button.linkButton
                                    [ Button.primary, Button.attrs [ onClick (ChangePage OutputProcess) ] ]
                                    [ text "Start" ]
                            ]
                        |> Card.view
                    ]
                ]
            ]
        ]

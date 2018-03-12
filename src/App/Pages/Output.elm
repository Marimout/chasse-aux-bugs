module App.Pages.Output exposing (outputView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Utils exposing (getStandardTable)


outputView : Model -> Html Msg
outputView model =
    div [ align "center" ]
        [ h2 [ class "ui center aligned header" ] [ text "Output Page" ]
        , div [ class "ui segment", style [ ( "width", "1200px" ) ] ]
            [ div [ class "ui vertically divided grid container" ]
                [ div [ class "eight wide column" ]
                    [ img [ src "logo-sg.png", width 300 ] []
                    ]
                , div [ class "eight wide column" ]
                    [ h2 [ class "ui right aligned header" ] [ text "RELEVE DE COMPTE" ]
                    ]
                , div [ class "sixteen wide column" ]
                    [ div [ class "ui divider", height 10 ] []
                    ]
                , div [ class "eight wide column" ]
                    [ h4 [ class "ui left aligned header" ] [ text "Votre agence FONTENAY LES DUNES" ]
                    , h4 [ class "ui left aligned header" ] [ text "Téléphone : 01 23 45 67 89" ]
                    , h4 [ class "ui left aligned header" ] [ text "Fax : 09 87 65 43 21" ]
                    ]
                , div [ class "seven wide column" ]
                    []
                , div [ class "fifteen wide column" ]
                    [ h3 [ class "ui right aligned header" ] [ text "M et Mme DUPONT" ]
                    , h4 [ class "ui right aligned header" ] [ text "12 rue de la Paix" ]
                    , h4 [ class "ui right aligned header" ] [ text "75001 PARIS" ]
                    ]
                , div [ class "sixteen wide column" ] []
                , div [ class "sixteen wide column" ]
                    [ h3 [ class "ui left aligned header" ] [ text "RELEVE DES OPERATIONS" ]
                    ]
                , div [ class "sixteen wide column" ]
                    [ getStandardTable model.currentInputSet.resultCsv
                    ]
                ]
            ]
        ]

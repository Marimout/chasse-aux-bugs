module App.Pages.Database exposing (databaseView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Record, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)

databaseView : Model -> Html Msg
databaseView model =
    div [ ]
        [ h2 [ class "ui center aligned header" ] [ text "Database Page" ]
        , div [ class "ui segment grid" ] 
            [ div [ class "sixteen wide column" ] 
                [ table [ class "ui celled table" ] (tableHeader :: (tableContentFromDatabase model)) 
                ]
            , div [ class "sixteen wide column" ]
                [ div [ class "ui form" ]
                    [ div [ class "field" ]
                        [ label [] [ text "Query"]
                        , textarea [] []
                        ]
                    ]
                ]
            , div [ class "center aligned sixteen wide column" ]
                [ button [ class "ui button centered" ] [ text "Executer" ] ]
            ]
        ]


tableHeader : Html Msg
tableHeader =
    thead []
        [
            tr []
            [ th [] [ text "N°" ]
            , th [] [ text "Date" ]
            , th [] [ text "Libellé" ]
            , th [] [ text "Montant" ]
            , th [] [ text "Devise" ]
            ]
        ]

tableContentFromDatabase : Model -> List (Html Msg)
tableContentFromDatabase model = 
    case model.data of
        Nothing ->
            []
        Just data ->
            data
                |> List.map tableItemFromDatabase
                |> List.map (tr [])

tableItemFromDatabase : Record -> List (Html Msg)
tableItemFromDatabase record =
    [ td [][ text (toString record.id) ]
    , td [][ text record.date ]
    , td [][ text record.libelle ]
    , td [][ text record.montant ]
    , td [][ text record.devise ]
    ]

tableContent : Model -> List (Html Msg)
tableContent model =
    case model.inputGlobalSheet of
        Nothing ->
            []

        Just inputGlobalSheet ->
            inputGlobalSheet.records
                |> List.map tableItem
                |> List.map (tr [])


tableItem : List String -> List (Html Msg)
tableItem csv =
    csv
        |> List.map text
        |> List.map List.singleton
        |> List.map (td [])

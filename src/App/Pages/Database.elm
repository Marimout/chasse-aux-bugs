module App.Pages.Database exposing (databaseView)

import App.Messages exposing (..)
import App.Model exposing (Model, Page(Overview), Record)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


databaseView : Model -> Html Msg
databaseView model =
    div []
        [ div [ class "ui segment grid" ]
            [ div [ class "sixteen wide column" ] [ h4 [ class "ui left aligned header" ] [ text "Nom de la table : TRANSACTION" ] ]
            , div [ class "sixteen wide column" ]
                [ table [ class "ui celled table" ] (tableHeader :: tableContentFromDatabase model)
                ]
            , div [ class "sixteen wide column" ]
                [ div [ class "ui form" ]
                    [ div [ class "field" ]
                        [ label [] [ text "Query" ]
                        , textarea [ onInput UpdateSqlQuery ] []
                        ]
                    ]
                ]
            , div [ class "center aligned sixteen wide column" ]
                [ button [ class "ui button centered", onClick (ExecuteQuery) ] [ text "Executer" ] ]
            ]
        ]


tableHeader : Html Msg
tableHeader =
    thead []
        [ tr []
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
    [ td [] [ text (toString record.id) ]
    , td [] [ text record.date ]
    , td [] [ text record.libelle ]
    , td [ class "right aligned" ] [ text record.montant ]
    , td [] [ text record.devise ]
    ]


tableContent : Model -> List (Html Msg)
tableContent model =
    model.inputGlobalSheet.records
        |> List.map tableItem
        |> List.map (tr [])


tableItem : List String -> List (Html Msg)
tableItem csv =
    csv
        |> List.map text
        |> List.map List.singleton
        |> List.map (td [])

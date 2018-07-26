module App.Pages.Database exposing (databaseView)

import App.Messages exposing (..)
import App.Model exposing (Model, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (viewIf)


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
    -- TODO: get from Csv headers
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
    case model.editingData of
        Nothing ->
            []

        Just data ->
            data
                |> List.indexedMap tableItemFromDatabase
                |> List.map (tr [])


tableItemFromDatabase : Int -> Record -> List (Html Msg)
tableItemFromDatabase rowId record =
    [ td
        []
        [ text (toString record.id) ]
    , td
        []
        [ div [ class "ui fluid transparent input" ]
            [ input
                [ type_ "text"
                , value record.date
                , attribute "data-row" (toString rowId)
                , attribute "data-col" "0"
                , attribute "data-fieldname" "date"
                , onTableCellInput EditDatabaseRecord
                ]
                []
            ]
        ]
    , td []
        [ div [ class "ui fluid transparent input" ]
            [ input
                [ type_ "text"
                , value record.libelle
                , attribute "data-row" (toString rowId)
                , attribute "data-col" "1"
                , attribute "data-fieldname" "libelle"
                , onTableCellInput EditDatabaseRecord
                ]
                []
            ]
        ]
    , td [ class "right aligned" ]
        [ div [ class "ui fluid transparent input" ]
            [ input
                [ type_ "text"
                , value record.montant
                , attribute "data-row" (toString rowId)
                , attribute "data-col" "2"
                , attribute "data-fieldname" "montant"
                , onTableCellInput EditDatabaseRecord
                ]
                []
            ]
        ]
    , td []
        [ div [ class "ui fluid transparent input" ]
            [ input
                [ type_ "text"
                , value record.devise
                , attribute "data-row" (toString rowId)
                , attribute "data-col" "3"
                , attribute "data-fieldname" "devise"
                , onTableCellInput EditDatabaseRecord
                ]
                []
            ]
        ]
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

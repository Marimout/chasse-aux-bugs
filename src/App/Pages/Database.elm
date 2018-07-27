module App.Pages.Database exposing (databaseView)

import App.Messages exposing (..)
import App.Model exposing (Model, Page(Overview))
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (viewIf, onTableCellInput)


databaseView : Model -> Html Msg
databaseView model =
    div []
        [ div [ class "ui segment grid" ]
            [ div [ class "sixteen wide column" ] [ h4 [ class "ui left aligned header" ] [ text "Nom de la table : DATA" ] ]
            , div [ class "sixteen wide column" ]
                [ table [ class "ui celled table" ]
                    [ tableHeader model.databaseData
                    , tableContent model.databaseData
                    ]
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


tableHeader : Csv -> Html Msg
tableHeader data =
    let
        headerMap name =
            th [] [ text name ]
    in
        thead [] [ tr [] (List.map headerMap data.headers) ]


tableContent : Csv -> Html Msg
tableContent data =
    let
        cellMap r c val =
            td []
                [ div [ class "ui fluid transparent input" ]
                    [ input
                        [ type_ "text"
                        , value val
                        , attribute "data-row" (toString r)
                        , attribute "data-col" (toString c)
                        , onTableCellInput EditDatabaseRecord
                        ]
                        []
                    ]
                ]

        rowMap id row =
            tr [] (List.indexedMap (cellMap id) row)
    in
        tbody [] (List.indexedMap rowMap data.records)

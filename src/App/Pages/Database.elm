module App.Pages.Database exposing (databaseView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

databaseView : Model -> Html Msg
databaseView model =
    div []
        [ img [ src "logo.svg" ] []
        , h1 [] [ text "Database Page" ]
        , table []
                (List.append tableHeader (tableContent model))
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

tableHeader : List(Html Msg)
tableHeader =
        [ th [][ text "N°" ]
        , th [][ text "Date" ]
        , th [][ text "Libellé" ]
        , th [][ text "Montant" ]
        ]

tableContent : Model -> List(Html Msg)
tableContent model = 
    case model.inputGlobalSheet of
        Nothing ->
            []
        Just inputGlobalSheet ->
            inputGlobalSheet.records
                |> List.map tableItem
                |> List.map (tr [])

tableItem : List(String) -> List(Html Msg)
tableItem csv =
    csv 
        |> List.map text
        |> List.map List.singleton
        |> List.map (td [])

module App.Pages.InputForm exposing (inputFormView)

import App.Messages exposing (Msg(ChangeInputSet, ChangePage))
import App.Model exposing (Model, Page(Overview))
import Csv exposing (Csv)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


inputFormView : Model -> Html Msg
inputFormView model =
    case model.level of
        Just level ->
            div [ class "ui grid" ]
                [ div [ class "four wide column" ] [ getInputsMenu model.currentInputSet.number <| List.length level.inputRowsBySheet - 1 ]
                , div [ class "twelve wide stretched column" ] [ getInputTable model.currentInputSet.inputCsv ]
                ]

        Nothing ->
            text ""


getInputsMenu : Int -> Int -> Html Msg
getInputsMenu currentSet setsNb =
    List.range 0 setsNb
        |> List.map
            (\i ->
                a
                    [ class
                        (if i == currentSet then
                            "active item"
                         else
                            "item"
                        )
                    , onClick (ChangeInputSet i)
                    ]
                    [ text <| "Jeu de données " ++ toString i ]
            )
        |> div [ class "ui vertical fluid pointing menu" ]


getInputTable : Csv -> Html Msg
getInputTable inputCsv =
    table [ class "ui celled table" ]
        [ thead []
            [ List.map (\h -> th [] [ text h ]) inputCsv.headers
                |> tr []
            ]
        , tbody []
            (inputCsv.records
                |> List.map
                    (\r ->
                        List.map (\v -> td [] [ text v ]) r
                            |> tr []
                    )
            )
        ]

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
                [ div [ class "four wide column" ] [ getInputsMenu model.currentInputSet <| List.length level.inputRowsBySheet - 1 ]
                , div [ class "twelve wide stretched column" ] [ getInputTable model.currentInputSet level.inputRowsBySheet model.inputGlobalSheet ]
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


getInputTable : Int -> List Int -> Maybe Csv -> Html Msg
getInputTable currentSet rowsBySheet globalSheet =
    case globalSheet of
        Just sheet ->
            table [ class "ui celled table" ]
                [ thead []
                    [ List.map (\h -> th [] [ text h ]) sheet.headers
                        |> tr []
                    ]
                , tbody []
                    (sheet.records
                        |> List.drop (List.sum <| List.take currentSet rowsBySheet)
                        |> List.take (Maybe.withDefault 0 <| List.head <| List.drop currentSet rowsBySheet)
                        |> List.map
                            (\r ->
                                List.map (\v -> td [] [ text v ]) r
                                    |> tr []
                            )
                    )
                ]

        Nothing ->
            text ""

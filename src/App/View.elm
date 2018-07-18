module App.View exposing (view)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (Model, Page(..))
import App.Pages.Database exposing (databaseView)
import App.Pages.InputForm exposing (inputFormView)
import App.Pages.Login exposing (loginView)
import App.Pages.Output exposing (outputView)
import App.Pages.Overview exposing (overviewView)
import App.Pages.Process exposing (processView)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (viewIf, dataToCsv, fullHeight)


view : Model -> Html Msg
view model =
    div [ fullHeight ]
        [ viewIf (not <| String.isEmpty model.errorMessage)
            (h3 [ class "ui block red header" ] [ text model.errorMessage ])
        , div [ class "ui segment grid" ]
            [ div [ class "two wide column" ]
                [ viewIf (List.any (\p -> p == model.page) [ Database, InputForm, Output, InputProcess, OutputProcess ])
                    (button
                        [ class "ui labeled icon button", onClick (ChangePage Overview) ]
                        [ i [ class "left arrow icon" ] [], text "Retour" ]
                    )
                ]
            , div [ class "twelve wide column" ] [ h1 [ class "ui centered header" ] [ text "La chasse aux bugs" ] ]
            ]
        , pageBody model
        ]


pageBody : Model -> Html Msg
pageBody model =
    case model.page of
        Login ->
            loginView (String.length model.team)

        Overview ->
            overviewView model

        InputForm ->
            inputFormView model

        InputProcess ->
            processView model model.inputBlockly model.currentInputSet.inputCsv

        Database ->
            databaseView model

        OutputProcess ->
            processView model model.outputBlockly (dataToCsv model)

        Output ->
            outputView model

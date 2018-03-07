module App.Pages.Process exposing (processView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (BlocklyData, Model, Page(Overview))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


processView : Model -> BlocklyData -> Html Msg
processView model blocklyData =
    div []
        [ h2 [ class "ui center aligned header" ] [ text "Process Page" ]
        , p [] [ text ("Toolbox: " ++ blocklyData.toolbox) ]
        , p [] [ text ("Workspace: " ++ blocklyData.workspace) ]
        , p [] [ text ("Script: " ++ blocklyData.script) ]
        ]

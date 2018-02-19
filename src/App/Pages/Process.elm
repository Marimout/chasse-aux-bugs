module App.Pages.Process exposing (processView)

import App.Messages exposing (Msg(ChangePage))
import App.Model exposing (BlocklyData, Model, Page(Overview))
import Html exposing (Html, button, div, h1, img, p, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


processView : Model -> BlocklyData -> Html Msg
processView model blocklyData =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Process Page" ]
        , p [] [ text ("Toolbox: " ++ blocklyData.toolbox) ]
        , p [] [ text ("Workspace: " ++ blocklyData.workspace) ]
        , p [] [ text ("Script: " ++ blocklyData.script) ]
        , button [ onClick (ChangePage Overview) ] [ text "go to Overview" ]
        ]

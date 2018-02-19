module App.Pages.Overview exposing (overviewView)

import App.Messages exposing (Msg, Msg(ChangePage))
import App.Model exposing (Model, Page(..))
import Html exposing (Html, div, h1, img, text, button)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


overviewView : Model -> Html Msg
overviewView model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Overview Page" ]
        , button [ onClick (ChangePage InputForm) ] [ text "go to Input form" ]
        , button [ onClick (ChangePage InputProcess) ] [ text "go to Input Process" ]
        , button [ onClick (ChangePage Database) ] [ text "go to Database" ]
        , button [ onClick (ChangePage OutputProcess) ] [ text "go to Output Process" ]
        , button [ onClick (ChangePage Output) ] [ text "go to Output" ]
        ]

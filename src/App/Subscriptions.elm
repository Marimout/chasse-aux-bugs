module App.Subscriptions exposing (subscriptions)

import App.Messages exposing (Msg)
import App.Model exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions model =
    always Sub.none model

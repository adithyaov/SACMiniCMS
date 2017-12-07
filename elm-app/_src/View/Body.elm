-- view/View.elm
module View.Body exposing (..)

import Html exposing (Html, div, text)
import Model.Model exposing (Model, Msg)

view : Model -> Html msg
view model =
    div [] [ text model ]
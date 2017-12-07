-- view/View.elm
module HeaderView exposing (..)

import Html exposing (Html, div, text)
import Model exposing (Model, Msg)

view : Model -> Html msg
view model =
    div [] [ text "Header" ]
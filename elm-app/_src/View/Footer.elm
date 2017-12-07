-- view/View.elm
module FooterView exposing (..)

import Html exposing (Html, div, text)
import Model exposing (Model, Msg)

view : Model -> Html msg
view model =
    div [] [ text "Footer" ]
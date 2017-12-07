-- view/View.elm
module View.View exposing (..)

import Html exposing (Html, div, text)
import Model.Model exposing (Model, Msg)
import View.Header as Header
import View.Body as Body
import View.Footer as Footer

view : Model -> Html msg
view model =
    div [] 
        [ Header.view model 
        , Body.view model
        , Footer.view model ]
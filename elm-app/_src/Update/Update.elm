-- update/Update.elm
module Update.Update exposing (..)

import Model.Model exposing (Model, Msg(..))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
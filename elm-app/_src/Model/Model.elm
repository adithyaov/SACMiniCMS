-- model/Model.elm
module Model.Model exposing (..)

type Msg = NoOp

type alias Model = String


init : ( Model, Cmd Msg )
init =
    ( "Hello, World!", Cmd.none )
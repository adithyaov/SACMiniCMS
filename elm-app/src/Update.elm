module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)
import Commands exposing (fetchHomeData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, commandOn newRoute )

        Msgs.OnFetchHomeData response ->
            ( { model | home = response }, Cmd.none )


commandOn : Models.Route -> Cmd Msg
commandOn route =
    case route of
        _ -> Cmd.none
module Msgs exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Models exposing (HomeModel, Model)

type Msg
    = OnLocationChange Location
    | OnFetchHomeData (WebData (HomeModel))
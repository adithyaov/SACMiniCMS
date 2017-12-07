module Msgs exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Models exposing (HomeModel, Model, MembersModel)

type Msg
    = OnLocationChange Location
    | OnFetchHomeData (WebData (HomeModel))
    | OnFetchMembersData (WebData (MembersModel))
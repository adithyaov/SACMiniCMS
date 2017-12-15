module Msgs exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Models exposing (BasicResponseModel, HomeModel, Model, MembersModel, Post, SubCouncilModel, FooterModel, EditRoute)

import Http

type Msg
    = OnLocationChange Location
    | OnFetchHomeData (WebData (HomeModel))
    | OnFetchMembersData (WebData (MembersModel))
    | OnFetchActivitiesData (WebData (List Post))
    | OnFetchSubCouncilData (WebData (SubCouncilModel))
    | OnFetchFooterData (WebData (FooterModel))
    | OnFeedback FeedbackMsgs
    | OnEditor EditMsgs

type FeedbackMsgs
    = OnFetchFeedbackResponse (Result Http.Error BasicResponseModel)
    | OnInputName String
    | OnInputEmail String
    | OnInputMessage String
    | OnSendFeedback

type EditMsgs
    = ChangeRoute EditRoute
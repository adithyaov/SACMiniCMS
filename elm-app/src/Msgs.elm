module Msgs exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Models exposing (FeedbackResponseModel, HomeModel, Model, MembersModel, Post, SubCouncilModel, FooterModel)

import Http

type Msg
    = OnLocationChange Location
    | OnFetchHomeData (WebData (HomeModel))
    | OnFetchMembersData (WebData (MembersModel))
    | OnFetchActivitiesData (WebData (List Post))
    | OnFetchSubCouncilData (WebData (SubCouncilModel))
    | OnFetchFooterData (WebData (FooterModel))
    | OnFeedback FeedbackMsgs

type FeedbackMsgs
    = OnFetchFeedbackResponse (Result Http.Error FeedbackResponseModel)
    | OnInputName String
    | OnInputEmail String
    | OnInputMessage String
    | OnSendFeedback
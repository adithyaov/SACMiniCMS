module Msgs exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Models exposing (BasicResponseModel, HomeModel, Model, MembersModel, Post, SubCouncilModel, FooterModel, EditRoute, Member, Post)

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
    | OnFetchAuthResponse (Result Http.Error BasicResponseModel)

type FeedbackMsgs
    = OnFetchFeedbackResponse (Result Http.Error BasicResponseModel)
    | OnInputName String
    | OnInputEmail String
    | OnInputMessage String
    | OnSendFeedback

type EditMsgs
    = ChangeRoute EditRoute
    | OnFormPost Post
    | OnFormMember Member
    | SubmitPostForm
    | SubmitMemberForm
    | SubmitStatic String String
    | OnFetchEditResponse EditResponse
    | Reload

type EditResponse
    = PostResponse (Result Http.Error Post)
    | MemberResponse (Result Http.Error Member)
    | StaticResponse (Result Http.Error BasicResponseModel)
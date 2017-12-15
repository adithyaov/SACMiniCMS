module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Models exposing (BasicResponseModel, HomeModel, MembersModel, FeedbackFormModel, Member, Post, SubCouncilModel, FooterModel)
import Msgs exposing (Msg)

import RemoteData

import Json.Encode as Encode

homeDataUrl : String
homeDataUrl =
    "http://localhost:4000/home"

fetchHomeData : Cmd Msg
fetchHomeData =
    Http.get homeDataUrl homeDataDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchHomeData

homeDataDecoder : Decode.Decoder HomeModel
homeDataDecoder =
  decode HomeModel
    |> required "content" postsDataDecoder
    |> required "directorQuote" Decode.string
    |> required "directorName" Decode.string
    |> required "imageBig" Decode.string



membersDataUrl : String
membersDataUrl =
    "http://localhost:4000/members"

fetchMembersData : Cmd Msg
fetchMembersData =
    Http.get membersDataUrl membersDataDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchMembersData

membersDataDecoder : Decode.Decoder MembersModel
membersDataDecoder =
    Decode.list memberDataDecoder

memberDataDecoder : Decode.Decoder Member
memberDataDecoder =
    decode Member
        |> required "name" Decode.string
        |> required "type" Decode.string
        |> required "email" Decode.string
        |> required "contact" Decode.string
        |> required "image" Decode.string
        |> required "position" Decode.string
        |> optional "id" Decode.int 0               -- ------------------------------------------------- Change


activitiesDataUrl : String -> String
activitiesDataUrl activity =
    "http://localhost:4000/" ++ (if activity == "technical" then "activities-technical" else "")

fetchActivitiesData : String -> Cmd Msg
fetchActivitiesData activity =
    Http.get (activitiesDataUrl activity) postsDataDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchActivitiesData

postsDataDecoder : Decode.Decoder (List Post)
postsDataDecoder =
    Decode.list postDataDecoder

postDataDecoder : Decode.Decoder Post
postDataDecoder =
    decode Post
        |> required "title" Decode.string
        |> required "content" (Decode.list Decode.string)
        |> optional "link" Decode.string ""
        |> optional "image" Decode.string ""
        |> optional "position" Decode.float 0.0
        |> optional "id" Decode.int 0               -- ------------------------------------------------- Change


subCouncilDataUrl : String -> String
subCouncilDataUrl council =
    "http://localhost:4000/" ++ (if council == "sports" then "sub-council-sports" else "")

fetchSubCouncilData : String -> Cmd Msg
fetchSubCouncilData council =
    Http.get (subCouncilDataUrl council) subCouncilDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchSubCouncilData

subCouncilDecoder : Decode.Decoder SubCouncilModel
subCouncilDecoder =
    decode SubCouncilModel
        |> required "content" postsDataDecoder
        |> required "image" Decode.string
        |> required "team" membersDataDecoder


footerDataUrl : String
footerDataUrl =
    "http://localhost:4000/footer"

fetchFooterData : Cmd Msg
fetchFooterData =
    Http.get footerDataUrl postsDataDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchFooterData

saveFeedbackUrl : String
saveFeedbackUrl =
    "http://www.mocky.io/v2/5a2dcbb7320000e4376fa8ce"


feedbackRequest : FeedbackFormModel -> Http.Request BasicResponseModel
feedbackRequest feedback =
    Http.request
        { body = feedbackEncoder feedback |> Http.jsonBody
        , expect = Http.expectJson basicResponseDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = saveFeedbackUrl
        , withCredentials = False
        }

basicResponseDecoder : Decode.Decoder BasicResponseModel
basicResponseDecoder =
    decode BasicResponseModel
        |> required "status" Decode.bool
        |> required "message" Decode.string

feedbackEncoder : FeedbackFormModel -> Encode.Value
feedbackEncoder feedback =
    let
        attributes =
            [ ( "name", Encode.string feedback.name )
            , ( "email", Encode.string feedback.email )
            , ( "message", Encode.string feedback.message )
            ]
    in
        Encode.object attributes

sendFeedbackCmd : FeedbackFormModel -> Cmd Msg
sendFeedbackCmd feedback =
    feedbackRequest feedback
        |> Http.send Msgs.OnFetchFeedbackResponse
        |> Cmd.map Msgs.OnFeedback
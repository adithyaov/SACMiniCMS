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
    "http://localhost:1337/display/home"

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
    |> required "directorNameId" Decode.int
    |> required "imageBigId" Decode.int
    |> required "directorQuoteId" Decode.int



membersDataUrl : String
membersDataUrl =
    "http://localhost:1337/display/members"

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
        |> required "id" Decode.int
        |> required "page" Decode.string


activitiesDataUrl : String -> String
activitiesDataUrl activity =
    "http://localhost:1337/display/activities/" ++ activity

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
        |> required "id" Decode.int
        |> required "page" Decode.string


subCouncilDataUrl : String -> String
subCouncilDataUrl council =
    "http://localhost:1337/display/council/" ++ council

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
    "http://localhost:1337/display/footer"

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



savePostUrl : String
savePostUrl = "http://localhost:1337/post"

saveMemberUrl : String
saveMemberUrl = "http://localhost:1337/member"


postEncoder : Post -> Encode.Value
postEncoder post =
    let
        attributes =
            [ ( "title", Encode.string post.title )
            , ( "content", Encode.list ( List.map Encode.string post.content ) )
            , ( "link", Encode.string post.link )
            , ( "image", Encode.string post.image )
            , ( "position", Encode.float post.position )
            , ( "page", Encode.string post.page )
            ]
    in
        Encode.object attributes

memberEncoder : Member -> Encode.Value
memberEncoder member =
    let
        attributes =
            [ ( "name", Encode.string member.name )
            , ( "email", Encode.string member.email )
            , ( "type", Encode.string member.type_ )
            , ( "contact", Encode.string member.contact )
            , ( "image", Encode.string member.image )
            , ( "position", Encode.string member.position )
            , ( "page", Encode.string member.page )
            ]
    in
        Encode.object attributes

staticEncoder : (String, String) -> Encode.Value
staticEncoder x =
    let
        (key, value) = x
        attributes =
            [ ( "key", Encode.string key )
            , ( "value", Encode.string value )
            ]
    in
        Encode.object attributes


editorRequest encoderType x url decoderType method =
    Http.request
        { body = encoderType x |> Http.jsonBody
        , expect = Http.expectJson decoderType
        , headers = []
        , method = method
        , timeout = Nothing
        , url = url
        , withCredentials = False
        }


editorCmd request responseMsg =
    request
        |> Http.send responseMsg
        |> Cmd.map Msgs.OnFetchEditResponse
        |> Cmd.map Msgs.OnEditor

saveStaticUrl : String
saveStaticUrl = "http://localhost:1337/static/customUpdate"


postCmd model = editorCmd (editorRequest postEncoder model.edit.newPost savePostUrl postDataDecoder "POST") Msgs.PostResponse
memberCmd model = editorCmd (editorRequest memberEncoder model.edit.newMember saveMemberUrl memberDataDecoder "POST") Msgs.MemberResponse
staticCmd key value model = editorCmd (editorRequest staticEncoder (key, value) saveStaticUrl basicResponseDecoder "POST") Msgs.StaticResponse
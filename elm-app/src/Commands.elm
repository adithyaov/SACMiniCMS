module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (HomeModel, MembersModel, Member)
import Msgs exposing (Msg)

import RemoteData

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
    |> required "about" (Decode.list Decode.string)
    |> required "directorQuote" Decode.string
    |> required "directorName" Decode.string
    |> required "imageBig" Decode.string
    |> required "imageLeft" Decode.string
    |> required "imageMiddle" Decode.string
    |> required "imageRight" Decode.string



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
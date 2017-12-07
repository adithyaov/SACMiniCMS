module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (HomeModel)
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

module Page.Home exposing (..)
import Models exposing (HomeModel, Model)
import Html exposing (Html, text, div, img, h2, p, cite, br)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import RemoteData exposing (WebData)
import Msgs exposing (Msg)

view : WebData (HomeModel) -> Html Msg
view response = maybeList response

maybeList : WebData (HomeModel) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text "NA"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success response ->
            viewSuccess response

        RemoteData.Failure error ->
            text (toString error)

viewSuccess : HomeModel -> Html msg
viewSuccess model = 
    div [ class "bg-white clearfix" ]
        [ div [ style [("min-width", "700px")], class "mx3 mt3 bg-white rounded" ]
            [ Header.view
            , div [ style [("height", "300px")], class "mx3 bg-black rounded overflow-hidden" ] []
            , div [ class "mt1 mx3 p2" ]
                [ div [ class "h2 bold mb2" ] [ text "About us." ]
                , div []
                    [ text (String.repeat 20 "lorem ipsum sprasam ")
                    , div [ class "p1" ] []
                    , text (String.repeat 20 "lorem ipsum sprasam ") ] ]
            , div [ class "mt1 mx3 p2" ]
                [ div [ style [("background-color", "#f9f9f0")], class "p2 border-left border-black" ]
                    [ div [ class "h3 bold" ] [ text (String.repeat 10 "lorem ipsum sprasam ") ]
                    , div [ class "clearfix" ] [ cite [ class "right h4" ] [ text "Sunil Kumar, Director, IIT Palakkad" ] ] ] ]
            , div [ class "mx3 mt2 clearfix" ] 
                [ div [ class "p1 col col-4" ] [ div [ style [("height", "200px")], class "bg-black rounded overflow-hidden" ] [] ]
                , div [ class "p1 col col-4" ] [ div [ style [("height", "200px")], class "bg-black rounded overflow-hidden" ] [] ]
                , div [ class "p1 col col-4" ] [ div [ style [("height", "200px")], class "bg-black rounded overflow-hidden" ] [] ] ]
            , div [ class "mx3 mb3 mt2 p2" ] [ text "copyright 2018 IIT Palakkad" ] ] ]
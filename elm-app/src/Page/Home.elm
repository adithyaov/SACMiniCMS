module Page.Home exposing (..)
import Models exposing (HomeModel, Model, Post, FooterModel)
import Html exposing (Html, text, div, img, h2, p, cite, br)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils

view : WebData (FooterModel) -> WebData (HomeModel) -> Html Msg
view footer response = 
    div [ class "bg-white clearfix" ]
        [ div []
            [ Header.view
            , mabeyResponse response
            , Footer.view footer ] ]

mabeyResponse : WebData (HomeModel) -> Html Msg
mabeyResponse response =
    case response of
        RemoteData.NotAsked ->
            div [ class "m3 p2 border" ] [ text "Not Requested" ]

        RemoteData.Loading ->
            div [ class "m3 p2 border" ] [ text "Loading..." ]

        RemoteData.Success response ->
            viewSuccess response

        RemoteData.Failure error ->
            div [ class "m3 p2 border" ] [ text ("[ERROR] -> " ++ (toString error)) ]



viewSuccess : HomeModel -> Html Msg
viewSuccess model = 
    div [] 
        [ div [ style [("background-image", "url(" ++ model.imageBig ++ ")")], class "bg-red overflow-hidden bg-cover bg-center" ]
            [ div [ class "center p4 m4 h1 bold caps white" ] [ text "SAC IIT PKD" ] ]
        , div [ class "mt3 px4" ]
            [ div [] (Utils.viewPosts model.content) ]
        , div [ class "px4 py2" ]
            [ div [ style [("background-color", "#f9f9f0")], class "p2 border-left border-black" ]
                [ div [ class "h3" ] [ text model.directorQuote ]
                , div [ class "clearfix" ] [ cite [ class "right h4" ] [ text model.directorName ] ] ] ] ]



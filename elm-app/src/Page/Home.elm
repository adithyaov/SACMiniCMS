module Page.Home exposing (..)
import Models exposing (HomeModel, Model, Post, FooterModel, DisplayMode)
import Html exposing (Html, text, div, img, h2, p, cite, br)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils

view : DisplayMode -> WebData (FooterModel) -> WebData (HomeModel) -> Html Msg
view mode footer response = 
    div [ class "bg-white clearfix" ]
        [ div []
            [ Header.view
            , mabeyResponse mode response
            , Footer.view mode footer ] ]

mabeyResponse : DisplayMode -> WebData (HomeModel) -> Html Msg
mabeyResponse mode response =
    case response of
        RemoteData.NotAsked ->
            div [ class "m3 p2 border" ] [ text "Not Requested" ]

        RemoteData.Loading ->
            div [ class "m3 p2 border" ] [ text "Loading..." ]

        RemoteData.Success response ->
            viewSuccess mode response

        RemoteData.Failure error ->
            div [ class "m3 p2 border" ] [ text ("[ERROR] -> " ++ (toString error)) ]



viewSuccess : DisplayMode -> HomeModel -> Html Msg
viewSuccess mode model = 
    div [] 
        [ div [ style [("background-image", "url(" ++ model.imageBig ++ ")")], class "bg-orange overflow-hidden bg-cover bg-center" ]
            [ div [ class "center p4 m4 h1 bold caps white" ] [ text "SAC IIT PKD" ] ]
        , div Utils.customContainerAttributes
            [ div [ class "mt3" ]
            [ div [ class "clearfix" ] (Utils.viewPosts mode model.content) ]
            , div [ class "py2" ]
                [ div [ style [("background-color", "#f9f9f0")], class "p2 border-left border-black" ]
                    [ div [ class "h3" ] [ text model.directorQuote ]
                    , div [ class "clearfix" ] [ cite [ class "right h4" ] [ text model.directorName ] ] ] ] ] ]

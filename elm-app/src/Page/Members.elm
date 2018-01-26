module Page.Members exposing (..)
import Models exposing (MembersModel, Model, Member, FooterModel, DisplayMode)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils

view : DisplayMode -> WebData (FooterModel) -> WebData (MembersModel) -> Html Msg
view mode footer response = 
    div [ class "bg-white clearfix" ]
        [ div []
            [ Header.view
            , mabeyResponse mode response
            , Footer.view mode footer ] ]

mabeyResponse : DisplayMode -> WebData (MembersModel) -> Html Msg
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


viewSuccess : DisplayMode -> MembersModel -> Html Msg
viewSuccess mode members = 
    div [] 
        [ div [ class "px4 py2 clearfix" ]
            [ div [ class "h5 caps mb1" ] [ text "Faculty Team" ]
            , div [] (List.map (Utils.cardFormat mode) (List.filter (\member -> member.type_ == "faculty") members)) ]
        ,div [ class "px4 py2 clearfix" ]
            [ div [ class "h5 caps mb1" ] [ text "Student Team" ]
            , div [] (List.map (Utils.cardFormat mode) (List.filter (\member -> member.type_ == "student") members)) ] ]



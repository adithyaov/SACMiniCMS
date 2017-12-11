module Page.Members exposing (..)
import Models exposing (MembersModel, Model, Member, FooterModel)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils

view : WebData (FooterModel) -> WebData (MembersModel) -> Html Msg
view footer response = 
    div [ class "bg-white clearfix" ]
        [ div [ style [("min-width", "700px")] ]
            [ Header.view
            , maybeList response
            , Footer.view footer ] ]

maybeList : WebData (MembersModel) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            div [ class "m3 p2 border" ] [ text "Not Requested" ]

        RemoteData.Loading ->
            div [ class "m3 p2 border" ] [ text "Loading..." ]

        RemoteData.Success response ->
            viewSuccess response

        RemoteData.Failure error ->
            div [ class "m3 p2 border" ] [ text ("[ERROR] -> " ++ (toString error)) ]


viewSuccess : MembersModel -> Html Msg
viewSuccess members = 
    div [] 
        [ div [ class "px4 py2 clearfix" ]
            [ div [ class "h5 caps bold mb1" ] [ text "Faculty Team" ]
            , div [] (List.map Utils.cardFormat (List.filter (\member -> member.type_ == "faculty") members)) ]
        ,div [ class "px4 py2 clearfix" ]
            [ div [ class "h5 caps bold mb1" ] [ text "Student Team" ]
            , div [] (List.map Utils.cardFormat (List.filter (\member -> member.type_ == "student") members)) ] ]



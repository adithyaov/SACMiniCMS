module Page.Members exposing (..)
import Models exposing (MembersModel, Model, Member)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import RemoteData exposing (WebData)
import Msgs exposing (Msg)

view : WebData (MembersModel) -> Html Msg
view response = 
    div [ class "bg-white clearfix" ]
        [ div [ style [("min-width", "700px")], class "mx3 mt3 bg-white rounded" ]
            [ Header.view
            , maybeList response ] ]

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
        [ div [ class "mx3 p2 clearfix" ]
            [ div [ class "h3 bold mb1" ] [ text "Faculty Team." ]
            , div [] (List.map card (List.filter (\member -> member.type_ == "faculty") members)) ]
        ,div [ class "mx3 p2 clearfix" ]
            [ div [ class "h3 bold mb1" ] [ text "Student Team." ]
            , div [] (List.map card (List.filter (\member -> member.type_ == "student") members)) ] ]


card : Member -> Html msg
card member =
    div [ style [("width", "220px")], class "left border rounded clearfix m1" ]
        [ div [ style [("height", "140px")], class "mx-auto bg-black" ] []
        , div [ class "bg-white mt1 px2" ]
            [ ul [ class "list-reset" ]
                [ li [] [ text member.name ]
                , li [] [ text member.position ]
                , li [] [ text member.email ]
                , li [] [ text member.contact ] ] ] ]
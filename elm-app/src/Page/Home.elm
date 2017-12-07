module Page.Home exposing (..)
import Models exposing (HomeModel, Model)
import Html exposing (Html, text, div, img, h2, p, cite, br)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import RemoteData exposing (WebData)
import Msgs exposing (Msg)

view : WebData (HomeModel) -> Html Msg
view response = 
    div [ class "bg-white clearfix" ]
        [ div [ style [("min-width", "700px")], class "mx3 mt3 bg-white rounded" ]
            [ Header.view
            , maybeList response ] ]

maybeList : WebData (HomeModel) -> Html Msg
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



viewSuccess : HomeModel -> Html msg
viewSuccess model = 
    div [] 
        [ div [ style [("height", "300px")], class "mx3 bg-black rounded overflow-hidden" ] []
        , div [ class "mt1 mx3 p2" ]
            [ div [ class "h2 bold mb2" ] [ text "About us." ]
            , div []
                (List.map (\para -> div [ class "my1" ] [ text para ]) model.about) ]
        , div [ class "mt1 mx3 p2" ]
            [ div [ style [("background-color", "#f9f9f0")], class "p2 border-left border-black" ]
                [ div [ class "h3 bold" ] [ text model.directorQuote ]
                , div [ class "clearfix" ] [ cite [ class "right h4" ] [ text model.directorName ] ] ] ]
        , div [ class "mx3 mt2 clearfix" ] 
            [ div [ class "p1 col col-4" ] [ div [ style [("height", "200px")], class "bg-black rounded overflow-hidden" ] [] ]
            , div [ class "p1 col col-4" ] [ div [ style [("height", "200px")], class "bg-black rounded overflow-hidden" ] [] ]
            , div [ class "p1 col col-4" ] [ div [ style [("height", "200px")], class "bg-black rounded overflow-hidden" ] [] ] ]
        , div [ class "mx3 mb3 mt2 p2" ] [ text "copyright 2018 IIT Palakkad" ] ]
module Page.Footer exposing (..)

import Html exposing (Html, div, text, a, ul, li)
import Html.Attributes exposing (class, href)
import Models exposing (Post, FooterModel)
import RemoteData exposing (WebData)

view : WebData (FooterModel) -> Html msg
view response =
    div [ class "clearfix py3 px4 white bg-black mt4" ]
        [ (maybeList response)
        , div [ class "right yellow" ] 
            [ div [ class "h5 caps bold" ] [ text "Copyright 2017 IIT Palakkad" ]
            , div [ class "right caps" ] [ text  "iitpkd.ac.in" ] ] ]

maybeList : WebData (FooterModel) -> Html msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            div [ class "left m3 p2 border" ] [ text "Not Requested" ]

        RemoteData.Loading ->
            div [ class "left m3 p2 border" ] [ text "Loading..." ]

        RemoteData.Success response ->
            viewSuccess response

        RemoteData.Failure error ->
            div [ class "left m3 p2 border" ] [ text ("[ERROR] -> " ++ (toString error)) ]


viewSuccess : FooterModel -> Html msg
viewSuccess cols =
    div [ class "clearfix" ] (viewCols cols)


viewCol : Post -> Html msg
viewCol col = 
    div [ class "left mr4" ]
        [ div [ class "bold h5 caps" ] [ text col.title ]
        , div [] 
            [ ul [ class "list-reset mt1" ]
                (List.map (\row -> (li [] [ text row ])) col.content) ] ]


viewCols : FooterModel -> List (Html msg)
viewCols cols =
    List.map viewCol cols
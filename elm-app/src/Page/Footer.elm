module Page.Footer exposing (..)

import Html exposing (Html, div, text, a, ul, li)
import Html.Attributes exposing (class, href, style)
import Models exposing (Post, FooterModel, DisplayMode(..))
import RemoteData exposing (WebData)
import Utils
import Html.Events exposing (onClick, on)
import Msgs exposing (Msg)

view : DisplayMode -> WebData (FooterModel) -> Html Msg
view mode response =
    div [ class "clearfix py3 white bg-black mt4" ]
        [ div Utils.customContainerAttributes
            [ (mabeyResponse mode response)
            , div [ class "right yellow" ] 
                [ div [ class "h5 caps bold" ] [ text "Copyright 2017 IIT Palakkad" ]
                , div [ class "right caps" ] [ text  "iitpkd.ac.in" ] ] ] ]

mabeyResponse : DisplayMode -> WebData (FooterModel) -> Html Msg
mabeyResponse mode response =
    case response of
        RemoteData.NotAsked ->
            div [ class "left m3 p2 border" ] [ text "Not Requested" ]

        RemoteData.Loading ->
            div [ class "left m3 p2 border" ] [ text "Loading..." ]

        RemoteData.Success response ->
            viewSuccess mode response

        RemoteData.Failure error ->
            div [ class "left m3 p2 border" ] [ text ("[ERROR] -> " ++ (toString error)) ]


viewSuccess : DisplayMode -> FooterModel -> Html Msg
viewSuccess mode cols =
    div [ class "clearfix" ] (viewCols mode cols)


viewCol : DisplayMode -> Post -> Html Msg
viewCol mode col =
    let
        deleteBtn =
            case mode of
                EditMode -> 
                    div [ onClick (Msgs.OnEditor (Msgs.DeletePost "id" (toString col.id))), class "py0 text-decoration-none px1 bg-red white absolute bottom-0 right-0 rounded" ] [ text "Delete" ]
                ViewMode ->
                    div [] []
    in
        div [ class "left mr4 relative" ]
            [ (deleteBtn)
            , div [ class "bold h5 caps" ] [ text col.title ]
            , div [] 
                [ ul [ class "list-reset mt1" ]
                    (List.map (\row -> (li [] [ text row ])) col.content) ] ]


viewCols : DisplayMode -> FooterModel -> List (Html Msg)
viewCols mode cols =
    List.map (viewCol mode) cols
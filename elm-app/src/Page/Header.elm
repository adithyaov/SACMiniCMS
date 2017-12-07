module Page.Header exposing (..)

import Html exposing (Html, div, text, a, ul, li)
import Html.Attributes exposing (class, href)

view : Html msg
view =
    div [ class "clearfix mx3 p2 bg-white" ]
        [ div [ class "bold left black" ] [ text "SAC IIT Palakkad" ] 
        , div [ class "right white" ] 
            [ ul [ class "list-reset m0 p0 inline-block" ]
                [ li [ class "inline-block ml2" ] [ a [ href "#", class "black" ] [ text "Home" ] ]
                , li [ class "inline-block ml2" ] [ a [ href "#members", class "black" ] [ text "Members" ] ] 
                , li [ class "inline-block ml2" ] [ a [ href "#", class "black" ] [ text "Sub Councils" ] ]
                , li [ class "inline-block ml2" ] [ a [ href "#", class "black" ] [ text "Activities" ] ]
                , li [ class "inline-block ml2" ] [ a [ href "#links", class "black" ] [ text "Links" ] ]
                , li [ class "inline-block ml2" ] [ a [ href "#feedback", class "black" ] [ text "Feedback" ] ] ] ] ]
module Page.Activity exposing (..)
import Models exposing (ActivitiesModel, FooterModel, Model, Post)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li, a)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils

view : String -> WebData (FooterModel) -> WebData (ActivitiesModel) -> Html Msg
view activity footer response = 
    div [ class "bg-white clearfix" ]
        [ div [ style [("min-width", "700px")] ]
            [ Header.view
            , inNav
            , div [ class "center caps px4 mt2 h5 bold" ] [ text (activity ++ " activities") ]
            , maybeList response 
            , Footer.view footer ] ]

maybeList : WebData (ActivitiesModel) -> Html Msg
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



viewSuccess : ActivitiesModel -> Html Msg
viewSuccess posts = 
    div [ class "px4 row clearfix" ]
        [ div [ style [("max-width", "620px")], class "mx-auto" ] (viewPosts posts) ]



viewPosts : List Post -> List (Html Msg)
viewPosts posts = 
    List.map viewPost posts

viewPost : Post -> Html Msg
viewPost post =
    div [ class "p1 mb2" ] 
        [ div [ style [("height", "200px"), ("background-image", "url(" ++ post.image ++ ")")], class "bg-gray bg-cover bg-center mb1" ]
            [ div [ class "px2 py1 left bg-black" ] [ a [ href post.link, class "h6 text-decoration-none yellow bold caps" ] [ text post.link ] ] ]
        , div [ class "bold underline" ] [ text post.title ]
        , div [] [ text post.content ] ]

inNav : Html Msg
inNav = 
    div [ class "center" ] 
        [ ul [ class "list-reset" ]
            [ li [ class "inline-block pr2 mb1" ] [ div [ class "p1 right-align" ] [ a [ href "/#activities/technical", class "text-decoration-none black" ] [ text "Technical" ] ] ]
            , li [ class "inline-block pr2 mb1" ] [ div [ class "p1 right-align" ] [ a [ href "/#activities/cultural", class "text-decoration-none black" ] [ text "Cultural" ] ] ]
            , li [ class "inline-block pr2 mb1" ] [ div [ class "p1 right-align" ] [ a [ href "/#activities/social", class "text-decoration-none black" ] [ text "Social" ] ] ]
            , li [ class "inline-block pr2 mb1" ] [ div [ class "p1 right-align" ] [ a [ href "/#activities/sports", class "text-decoration-none black" ] [ text "Sports" ] ] ]
            , li [ class "inline-block pr2 mb1" ] [ div [ class "p1 right-align" ] [ a [ href "/#activities/other", class "text-decoration-none black" ] [ text "Others" ] ] ] ] ]
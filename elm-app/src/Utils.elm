module Utils exposing (..)
import Char
import Models exposing (Member, Post)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li)
import Html.Attributes exposing (class, href, src, style)
import Msgs exposing (Msg)

titleFormat : String -> String
titleFormat str =
    case String.uncons str of
        Just (f, rest) -> String.cons (Char.toUpper f) rest
        _ -> str

cardFormat : Member -> Html msg
cardFormat member =
    div [ style [("width", "200px")], class "left border border-gray clearfix mr2 mb1 mt1" ]
        [ div [ style [("height", "140px"), ("background-image", "url(" ++ member.image ++ ")")], class "mx-auto bg-gray bg-cover bg-top" ] []
        , div [ class "bg-white mt1 px2" ]
            [ ul [ class "list-reset" ]
                [ li [] [ text member.name ]
                , li [] [ text member.position ]
                , li [] [ text member.email ]
                , li [] [ text member.contact ] ] ] ]

viewPosts : List Post -> List (Html Msg)
viewPosts posts = 
    List.map viewPost posts

viewPost : Post -> Html Msg
viewPost post =
    div [ class "mb3" ]
        [ div [ class "caps h5 bold" ] [ text post.title ]
        , div [] [ text post.content ] ]
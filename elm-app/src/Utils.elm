module Utils exposing (..)
import Char
import Models exposing (Member, Post, Model)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li, Attribute, input, label)
import Html.Attributes exposing (class, href, src, style, type_, value)
import Html.Events exposing (on)
import Msgs exposing (Msg)
import Json.Decode as Json

titleFormat : String -> String
titleFormat str =
    case String.uncons str of
        Just (f, rest) -> String.cons (Char.toUpper f) rest
        _ -> str

cardFormat : Member -> Html msg
cardFormat member =
    div [ style [("width", "200px")], class "left border border-gray clearfix mr2 mb1 mt1" ]
        [ div [ style [("height", "140px"), ("background-image", "url(" ++ member.image ++ ")")], class "mx-auto bg-gray bg-cover bg-center" ] []
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
        , div [] (List.map (\paragraph -> div [] [ text paragraph ]) post.content) ]


onChange : (String -> msg) -> Attribute msg
onChange handler = 
    on "change" <| Json.map handler <| Json.at ["target", "value"] Json.string


editBox labelText onChangeFunc =
    div []
        [ label [ class "label" ] [ text labelText ]
        , input [ class "input", type_ "text", onChange onChangeFunc ] [] ]
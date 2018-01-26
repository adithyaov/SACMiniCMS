module Utils exposing (..)
import Char
import Models exposing (Member, Post, Model, DisplayMode(..))
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li, Attribute, input, label)
import Html.Attributes exposing (class, href, src, style, type_, value)
import Html.Events exposing (onClick, on)
import Msgs exposing (Msg)
import Json.Decode as Json

titleFormat : String -> String
titleFormat str =
    case String.uncons str of
        Just (f, rest) -> String.cons (Char.toUpper f) rest
        _ -> str

cardFormat : DisplayMode -> Member -> Html Msg
cardFormat mode member =
    let
        deleteBtn =
            case mode of
                EditMode -> 
                    div [ onClick (Msgs.OnEditor (Msgs.DeleteMember "id" (toString member.id))), class "py1 text-decoration-none px1 bg-red white" ] [ text "Delete" ]
                ViewMode ->
                    div [] []
    in
        div [ style [("width", "200px")], class "left border border-gray clearfix mr2 mb1 mt1" ]
            [ div [ style [("height", "140px"), ("background-image", "url(" ++ member.image ++ ")")], class "mx-auto bg-gray bg-cover bg-top" ] [ (deleteBtn) ]
            , div [ class "bg-white mt1 px2 overflow-scroll" ]
                [ ul [ class "list-reset" ]
                    [ li [ class "nowrap" ] [ text member.name ]
                    , li [ class "nowrap" ] [ text member.position ]
                    , li [ class "nowrap" ] [ text member.email ]
                    , li [ class "nowrap" ] [ text member.contact ] ] ] ]

viewPosts : DisplayMode -> List Post -> List (Html Msg)
viewPosts mode posts = 
    List.map (viewPost mode) posts

--viewPost : Post -> Html Msg
--viewPost post =
--    div [ class "mb3" ]
--        [ div [ class "caps h5 bold" ] [ text post.title ]
--        , div [] (List.map (\paragraph -> div [] [ text paragraph ]) post.content) ]

postAttr = 
    [ style
        [ ("-webkit-box-shadow", "0px 0px 2px -1px #000000")
        , ("box-shadow", "0px 0px 2px -1px #000000")
        , ("border-left", "3px solid #999") ]
    , class "mt1 mr2 mb1 px2 py1" ]

viewPost : DisplayMode -> Post -> Html Msg
viewPost mode post =
    let
        deleteBtn =
            case mode of
                EditMode -> 
                    div [ onClick (Msgs.OnEditor (Msgs.DeletePost "id" (toString post.id))), class "py0 text-decoration-none px1 bg-red white absolute top-0 right-0 rounded" ] [ text "Delete" ]
                ViewMode ->
                    div [] []
    in
        div [ class "relative mx-auto pb3", style [("max-width", "1000px")] ]
            [ (deleteBtn)
            , div [ class "clearfix" ]
            [ div [ class "md-col md-col-2" ] 
                [ div [ class "caps bold h3 my1" ] [ text post.title ] ]
            , div [ class "md-col md-col-10" ] [ (paraWrapping post.content) ] ] ]


valOf backup x =
    case x of
        Just x -> x
        Nothing -> backup

-- The parsing can be only in the first line
-- eg. *adv* col-6
paraWrapping content =
    let
        parsed =
            div [ class "ml2 pl2 border-left" ] 
                (List.map (\paragraph -> 
                    div [] 
                        [ div [ class "my1" ] [ text paragraph ] ]) content)

    in
        parsed

            

onChange : (String -> msg) -> Attribute msg
onChange handler = 
    on "change" <| Json.map handler <| Json.at ["target", "value"] Json.string


editBox labelText onChangeFunc =
    div []
        [ label [ class "label" ] [ text labelText ]
        , input [ class "input", type_ "text", onChange onChangeFunc ] [] ]


customContainerAttributes = [ class "px4" ]
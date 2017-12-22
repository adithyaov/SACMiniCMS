module Page.Edit exposing (..)

import Html exposing (Html, div, text, input, label, select, option, textarea, ul, li)
import Html.Attributes exposing (class, type_, style, value, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (Model, BasicResponseModel, Post, Member)
import Msgs exposing (Msg)
import Http
import Utils


view : Model -> Html Msg
view model = 
    div [ class "bg-yellow black p2" ]
        [ div [ class "h5 bold caps" ] [ text "Editor" ]
        , div [ class "mt2" ]
            [ nav
            , displayWhat model.edit ] ]

parseRoute route =
    route
        |> Msgs.ChangeRoute
        |> Msgs.OnEditor


makePost title content link image position id page =
    Post title content link image position id page

setEditPost : String -> Post -> String -> Msg
setEditPost whichAttr prevPost x =
    let
        post =
            case whichAttr of
                "title" -> { prevPost | title = x }
                "link" -> { prevPost | link = x }
                "image" -> { prevPost | image = x }
                "page" -> { prevPost | page = x }
                "content" -> { prevPost | content = parseContent x }
                "position" -> { prevPost | position = parsePosition x }
                _ -> prevPost
    in
        msgForm Msgs.OnFormPost post

parsePosition : String -> Float
parsePosition x =
    let
        r = String.toFloat x
    in
        case r of
            Err e -> 0.0
            Ok converted -> converted


parseContent : String -> List String
parseContent x =
    let
        splitted = String.split "\n" x
        trimmed = List.map String.trim splitted
        filtered = List.filter (\b -> String.isEmpty b == False) trimmed 
    in         
        trimmed


revParsePosition : Float -> String
revParsePosition x =
    toString x


revParseContent : List String -> String
revParseContent x =
    let
        joinFunc a b = a ++ "\n" ++ b
        joined = List.foldr joinFunc "" x
    in         
        joined


msgForm formType x =
    x
        |> formType
        |> Msgs.OnEditor



setEditMember : String -> Member -> String -> Msg
setEditMember whichAttr prevMember x =
    let
        member =
            case whichAttr of
                "name" -> { prevMember | name = x }
                "type" -> { prevMember | type_ = x }
                "email" -> { prevMember | email = x }
                "contact" -> { prevMember | contact = x }
                "image" -> { prevMember | image = x }
                "position" -> { prevMember | position = x }
                "page" -> { prevMember | page = x }
                _ -> prevMember
    in
        msgForm Msgs.OnFormMember member


nav : Html Msg
nav =
    ul [ class "list-reset" ]
        [ li [ class "inline-block mr2 underline", onClick (parseRoute Models.EditPostRoute), style [("cursor", "pointer")] ] [ text "Add Post" ]
        , li [ class "inline-block mr2 underline", onClick (parseRoute Models.EditMemberRoute), style [("cursor", "pointer")] ] [ text "Add Member" ]
        , li [ class "inline-block mr2 underline", onClick (parseRoute Models.EditStaticRoute), style [("cursor", "pointer")] ] [ text "Set Static" ] ]

displayWhat : Models.EditModel -> Html Msg
displayWhat editModel =
    case editModel.route of
        Models.EditPostRoute ->
            addAPostForm editModel.newPost
        Models.EditMemberRoute ->
            addAMemberForm editModel.newMember
        Models.EditStaticRoute ->
            staticEditForm


addAPostForm : Post -> Html Msg
addAPostForm prevPost =
    div [ class "border-top border-black py1 mb1" ]
        [ div []
            [ label [ class "label" ] [ text "Title*" ]
            , input [ type_ "text", class "input", onInput (setEditPost "title" prevPost), value prevPost.title ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Content*" ]
            , textarea [ class "input", style [("height", "150px")],  onInput (setEditPost "content" prevPost)  ] [ text (revParseContent prevPost.content) ] ] 
        , div []
            [ label [ class "label" ] [ text "Link" ]
            , input [ type_ "text", class "input", onInput (setEditPost "link" prevPost), value prevPost.link ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Image" ]
            , input [ type_ "text", class "input", onInput (setEditPost "image" prevPost), value prevPost.image ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Position" ]
            , input [ type_ "text", class "input", onInput (setEditPost "position" prevPost), value (revParsePosition prevPost.position) ] [] ]
        , div []
            [ label [ class "label" ] [ text "Page" ]
            , select [ class "select", Utils.onChange (setEditPost "page" prevPost) ] (pageOptionsPost) ]
                
        , div []
            [ input [ class "btn btn-primary bg-black", type_ "submit", value "Add Post", onClick (Msgs.OnEditor Msgs.SubmitPostForm) ] [] ] 
        ]

pageOptionsPost : List (Html Msg)
pageOptionsPost =
    [ option [ value "home" ] [ text "Home" ]
    , option [ value "council.sports" ] [ text "Sports Council" ] 
    , option [ value "council.technical" ] [ text "Technical Council" ] 
    , option [ value "council.cultural" ] [ text "Cultural Council" ] 
    , option [ value "activities.technical" ] [ text "Technical Activities" ] 
    , option [ value "activities.cultural" ] [ text "Cultural Activities" ] 
    , option [ value "activities.sports" ] [ text "Sports Activities" ] 
    , option [ value "activities.social" ] [ text "Social Activities" ] 
    , option [ value "activities.other" ] [ text "Other Activities" ]
    , option [ value "footer" ] [ text "Footer" ] ]


addAMemberForm : Member -> Html Msg
addAMemberForm prevMember =
    div [ class "border-top border-black py1 mb1" ]
        [ div []
            [ label [ class "label" ] [ text "Name*" ]
            , input [ type_ "text", class "input", onInput (setEditMember "name" prevMember), value prevMember.name] [] ] 
        , div []
            [ label [ class "label" ] [ text "Type*" ]
            , select [ class "select", Utils.onChange (setEditMember "type" prevMember) ] (typeOptionsMember) ] 
        , div []
            [ label [ class "label" ] [ text "Email*" ]
            , input [ type_ "text", class "input", onInput (setEditMember "email" prevMember), value prevMember.email ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Contact*" ]
            , input [ type_ "text", class "input", onInput (setEditMember "contact" prevMember), value prevMember.contact ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Image*" ]
            , input [ type_ "text", class "input", onInput (setEditMember "image" prevMember), value prevMember.image ] [] ]
        , div []
            [ label [ class "label" ] [ text "Position*" ]
            , input [ type_ "text", class "input", onInput (setEditMember "position" prevMember), value prevMember.position ] [] ]
        , div []
            [ label [ class "label" ] [ text "Page*" ]
            , select [ class "select", Utils.onChange (setEditMember "page" prevMember) ] (pageOptionsMember) ]
        , div []
            [ input [ class "btn btn-primary bg-black", type_ "submit", value "Add Member", onClick (Msgs.OnEditor Msgs.SubmitMemberForm) ] [] ] 
        ]


typeOptionsMember : List (Html Msg)
typeOptionsMember = 
    [ option [ value "student" ] [ text "Student" ]
    , option [ value "faculty" ] [ text "Faculty" ] ]

pageOptionsMember : List (Html Msg)
pageOptionsMember =
    [ option [ value "members" ] [ text "Members" ]
    , option [ value "council.sports" ] [ text "Sports Council" ] 
    , option [ value "council.technical" ] [ text "Technical Council" ] 
    , option [ value "council.cultural" ] [ text "Cultural Council" ] ]



staticEditForm =
    div [ class "border-top border-black py1 mb1" ]
        [ Utils.editBox "New Home Image" (msgForm (Msgs.SubmitStatic "home.imageBig"))
        , Utils.editBox "New Sports Council Image" (msgForm (Msgs.SubmitStatic "council.sports.image"))
        , Utils.editBox "New Technical Council Image" (msgForm (Msgs.SubmitStatic "council.technical.image"))
        , Utils.editBox "New Cultural Council Image" (msgForm (Msgs.SubmitStatic "council.cultural.image"))
        , Utils.editBox "New Director Name" (msgForm (Msgs.SubmitStatic "home.directorName"))
        , Utils.editBox "New Director Quote" (msgForm (Msgs.SubmitStatic "home.directorQuote")) ]
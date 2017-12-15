module Page.Edit exposing (..)

import Html exposing (Html, div, text, input, label, select, option, textarea, ul, li)
import Html.Attributes exposing (class, type_, style, value, placeholder)
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model = 
    div [ class "bg-yellow black p2" ]
        [ div [ class "h5 bold caps" ] [ text "Editor" ]
        , div [ class "mt2" ]
            [ nav
            , displayWhat model.edit.route ] ]


parseRoute route =
    route
        |> Msgs.ChangeRoute
        |> Msgs.OnEditor

nav : Html Msg
nav =
    ul [ class "list-reset" ]
        [ li [ class "inline-block mr2 underline", onClick (parseRoute Models.EditPostRoute) ] [ text "Add Post" ]
        , li [ class "inline-block mr2 underline", onClick (parseRoute Models.EditMemberRoute) ] [ text "Add Member" ]
        , li [ class "inline-block mr2 underline" ] [ text "Instructions" ] ]

displayWhat : Models.EditRoute -> Html Msg
displayWhat route =
    case route of
        Models.EditPostRoute ->
            addAPostForm
        Models.EditMemberRoute ->
            addAMemberForm

addAPostForm : Html Msg
addAPostForm =
    div [ class "border-top border-black py1 mb1" ]
        [ div []
            [ label [ class "label" ] [ text "Title*" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Content*" ]
            , textarea [ class "input", style [("height", "150px")] ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Link" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Image" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Position" ]
            , input [ type_ "text", class "input" ] [] ]
        , div []
            [ label [ class "label" ] [ text "Page" ]
            , select [ class "select" ]
                [ option [ value "home" ] [ text "Home" ] ] ]
        , div []
            [ input [ class "btn btn-primary bg-black", type_ "submit", value "Add Post" ] [] ] 
        ]



addAMemberForm : Html Msg
addAMemberForm =
    div [ class "border-top border-black py1 mb1" ]
        [ div []
            [ label [ class "label" ] [ text "Name*" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Type*" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Email*" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Contact*" ]
            , input [ type_ "text", class "input" ] [] ] 
        , div []
            [ label [ class "label" ] [ text "Image*" ]
            , input [ type_ "text", class "input" ] [] ]
        , div []
            [ label [ class "label" ] [ text "Position*" ]
            , input [ type_ "text", class "input" ] [] ]
        , div []
            [ label [ class "label" ] [ text "Page*" ]
            , select [ class "select" ]
                [ option [ value "home" ] [ text "Members" ] ] ]
        , div []
            [ input [ class "btn btn-primary bg-black", type_ "submit", value "Add Member" ] [] ] 
        ]
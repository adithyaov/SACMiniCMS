module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model)
import Msgs exposing (Msg)
import Page.Home
import Page.Members

view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            Page.Home.view model.home

        Models.MembersRoute ->
            Page.Members.view model.members

        Models.ActivityRoute activity ->
            Page.Home.view model.home

        Models.SubCouncilRoute council ->
            Page.Home.view model.home

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]

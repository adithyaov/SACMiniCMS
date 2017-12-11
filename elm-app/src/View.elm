module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model)
import Msgs exposing (Msg)
import Page.Home
import Page.Members
import Page.Activity
import Page.SubCouncil
import Page.Feedback

view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            Page.Home.view model.footer model.home

        Models.MembersRoute ->
            Page.Members.view model.footer model.members

        Models.ActivityRoute activity ->
            Page.Activity.view activity model.footer model.activities

        Models.SubCouncilRoute council ->
            Page.SubCouncil.view council model.footer model.council

        Models.FeedbackRoute ->
            Page.Feedback.view model.footer model.feedback

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]

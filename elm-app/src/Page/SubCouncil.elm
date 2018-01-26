module Page.SubCouncil exposing (..)
import Models exposing (SubCouncilModel, Model, FooterModel, DisplayMode)
import Html exposing (Html, text, div, img, h2, p, cite, br, ul, li, a)
import Html.Attributes exposing (class, href, src, style)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils

view : DisplayMode -> String -> WebData (FooterModel) -> WebData (SubCouncilModel) -> Html Msg
view mode council footer response = 
    div [ class "bg-white clearfix" ]
        [ div []
            [ Header.view
            , mabeyResponse mode council response
            , Footer.view mode footer ] ]

mabeyResponse : DisplayMode -> String -> WebData (SubCouncilModel) -> Html Msg
mabeyResponse mode council response =
    case response of
        RemoteData.NotAsked ->
            div [ class "m3 p2 border" ] [ text "Not Requested" ]

        RemoteData.Loading ->
            div [ class "m3 p2 border" ] [ text "Loading..." ]

        RemoteData.Success response ->
            viewSuccess mode council response

        RemoteData.Failure error ->
            div [ class "m3 p2 border" ] [ text ("[ERROR] -> " ++ (toString error)) ]



viewSuccess : DisplayMode -> String -> SubCouncilModel -> Html Msg
viewSuccess mode council model = 
    div [] 
        [ div [ style [("background-image", "url(" ++ model.image ++ ")")], class "bg-blue overflow-hidden bg-cover bg-center" ]
            [ miniNav
            , div [ class "white pb4 pt1 px4 m4 center h1 bold caps" ] [ text (council ++ " Council") ] ]
        , div [ class "mt3" ]
            [ div Utils.customContainerAttributes
                [ div [ class "mt3" ] (Utils.viewPosts mode model.content)
                , div [ class "relative mx-auto", style [("max-width", "1000px")] ]
                    [ div [ class "h3 bold caps" ] [ text "Team" ]
                    , div [ class "clearfix" ] (List.map (Utils.cardFormat mode) model.team) ] ] ] ]


miniNav = 
    div [ class "center p3" ]
        [ ul [ class "list-reset m0 p0" ]
            [ li [ class "inline-block mx1 rounded border border-white p2" ] [ a [ href "/#sub-council/sports",class "text-decoration-none h5 bold white" ] [ text "Sports" ] ]
            , li [ class "inline-block mx1 rounded border border-white p2" ] [ a [ href "/#sub-council/technical",class "text-decoration-none h5 bold white" ] [ text "Technical" ] ]
            , li [ class "inline-block mx1 rounded border border-white p2" ] [ a [ href "/#sub-council/cultural",class "text-decoration-none h5 bold white" ] [ text "Cultural" ] ] ] ]
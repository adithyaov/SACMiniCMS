module Page.Feedback exposing (..)
import Models exposing (FooterModel, FeedbackModel, BasicResponseModel)
import Html exposing (Html, text, div, img, h2, p, cite, br, input, textarea, label)
import Html.Attributes exposing (class, href, src, style, type_, placeholder, value, required)
import Html.Events exposing (onClick, onInput)
import Page.Header as Header
import Page.Footer as Footer
import RemoteData exposing (WebData)
import Msgs exposing (Msg)
import Utils
import Http

view : WebData (FooterModel) -> FeedbackModel -> Html Msg
view footer feedback = 
    div [ class "bg-white clearfix" ]
        [ div []
            [ Header.view
            , div [ class "px4 py2 mx-auto", style [("max-width", "800px")] ]
                [ div [ class "h5 bold caps" ] [ text "Feedback" ]
                , div [ class "red italic mb1" ] [ text "Please fill out all the fields*" ]
                , displayForm feedback.response ]
            , Footer.view footer ] ]


viewForm : Html Msg
viewForm =            
    div []
        [ div [] 
            [ label [ class "label" ] [ text "name*" ]
            , input [ type_ "text", placeholder "eg. Luke Skywalker", class "input", required True, onInput (\x -> Msgs.OnFeedback (Msgs.OnInputName x)) ] [] ]
        , div [] 
            [ label [ class "label" ] [ text "email*" ]
            , input [ type_ "email", placeholder "eg. luke@jedi.com", class "input", required True, onInput (\x -> Msgs.OnFeedback (Msgs.OnInputEmail x)) ] [] ]
        , div [] 
            [ label [ class "label" ] [ text "message*" ]
            , textarea [ placeholder "May the force be with you :-)", class "input", style [("height", "120px")], onInput (\x -> Msgs.OnFeedback (Msgs.OnInputMessage x)) ] [] ]
        , input [ type_ "submit", value "Submit", class "btn btn-primary", onClick (Msgs.OnFeedback Msgs.OnSendFeedback) ] [] ]


displayForm : Maybe (Result Http.Error BasicResponseModel) -> Html Msg
displayForm feedback =
    let
        display feedback =
            case feedback of
                Nothing -> div [] [ viewForm ]
                Just response -> displayResponse response

        displayResponse response =
            case response of
                Result.Err error ->
                        div [ class "p2 my3 bg-red rounded white" ] [ text ("[ERROR] -> " ++ (toString error)) ]
                Result.Ok result ->
                    displayResult result

        displayResult result =
            if result.status == True then
                div [ class "p2 my3 bg-green rounded white" ] [ text result.message ]
            else
                div [] 
                    [ div [ class "p2 my1 bg-red white rounded" ] [ text result.message ] 
                    , viewForm]
    in
        display feedback
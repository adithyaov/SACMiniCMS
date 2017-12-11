module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)
import Commands exposing (fetchHomeData, fetchMembersData, fetchActivitiesData, fetchSubCouncilData, sendFeedbackCmd)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, commandOn newRoute )

        Msgs.OnFetchHomeData response ->
            ( { model | home = response }, Cmd.none )

        Msgs.OnFetchMembersData response ->
            ( { model | members = response }, Cmd.none )

        Msgs.OnFetchActivitiesData response ->
            ( { model | activities = response }, Cmd.none )

        Msgs.OnFetchSubCouncilData response ->
            ( { model | council = response }, Cmd.none )

        Msgs.OnFetchFooterData response ->
            ( { model | footer = response }, Cmd.none )

        Msgs.OnFeedback feedbackMsg ->
            updateFeedback feedbackMsg model


updateFeedback : Msgs.FeedbackMsgs -> Model -> ( Model, Cmd Msg )
updateFeedback msg model = 
    let
        feedbackModel = model.feedback
        prevName = model.feedback.form.name
        prevEmail = model.feedback.form.email
        prevMessage = model.feedback.form.message
        formModel name email message =
            { model | feedback = 
                { feedbackModel | form =
                    { name = name
                    , email = email
                    , message = message } } }
        responseModel response =
            { model | feedback = 
                { feedbackModel | response = response } }
    in        
        case msg of
            Msgs.OnSendFeedback ->
                ( model, sendFeedbackCmd model.feedback.form )
            Msgs.OnInputName name ->
                ( formModel name prevEmail prevMessage, Cmd.none )
            Msgs.OnInputEmail email ->
                ( formModel prevName email prevMessage, Cmd.none )
            Msgs.OnInputMessage message ->
                ( formModel prevName prevEmail message, Cmd.none )
            Msgs.OnFetchFeedbackResponse response ->
                ( responseModel (Just response), Cmd.none )


commandOn : Models.Route -> Cmd Msg
commandOn route =
    case route of
        Models.MembersRoute -> fetchMembersData
        Models.HomeRoute -> fetchHomeData
        Models.ActivityRoute activity -> fetchActivitiesData activity
        Models.SubCouncilRoute council -> fetchSubCouncilData council
        _ -> Cmd.none
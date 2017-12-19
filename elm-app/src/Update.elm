module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Post, Member)
import Routing exposing (parseLocation)
import Commands exposing (..)


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
            ( model
                |> setHomeResponse response, Cmd.none )

        Msgs.OnFetchMembersData response ->
            ( model
                |> setMembersResponse response, Cmd.none )

        Msgs.OnFetchActivitiesData response ->
            ( model
                |> setActivitiesResponse response, Cmd.none )

        Msgs.OnFetchSubCouncilData response ->
            ( model
                |> setCouncilResponse response, Cmd.none )

        Msgs.OnFetchFooterData response ->
            ( model
                |> setFooterResponse response, Cmd.none )

        Msgs.OnFeedback feedbackMsg ->
            updateFeedback feedbackMsg model

        Msgs.OnEditor editMsg ->
            updateEdit editMsg model


updateEdit : Msgs.EditMsgs -> Model -> ( Model, Cmd Msg )
updateEdit msg model =
    let
        editModel = model.edit
        newPost = model.edit.newPost
        newMember = model.edit.newMember
    in
        case msg of
            Msgs.ChangeRoute route ->
                ( changeEditRoute route model, Cmd.none )
            Msgs.OnFormPost post ->
                ( model
                    |> setNewPost post editModel, Cmd.none )
            Msgs.OnFormMember member ->
                ( model
                    |> setNewMember member editModel, Cmd.none )
            Msgs.OnFetchEditResponse response ->
                ( model 
                    |> editResponse response,  Cmd.batch [ commandOn model.route, fetchFooterData ] )

            Msgs.SubmitPostForm ->
                ( model
                    |> changeAlertMsg "Loading..." editModel, postCmd model )

            Msgs.SubmitStatic key value ->
                ( model
                    |> changeAlertMsg "Loading..." editModel, staticCmd key value model )

            Msgs.SubmitMemberForm ->
                ( model
                    |> changeAlertMsg "Loading..." editModel, memberCmd model )

            Msgs.Reload ->
                ( model
                    |> changeAlertMsg "Loading..." editModel, Cmd.batch [ commandOn model.route, fetchFooterData ] )

changeAlertMsg message editModel model =
    { model | edit = { editModel | alert = message } }

setNewPost post editModel model =
    { model | edit = { editModel | newPost = post } }

setNewMember member editModel model = 
    { model | edit = { editModel | newMember = member } }

setHomeResponse response model =
    { model | home = response }

setMembersResponse response model =
    { model | members = response }

setActivitiesResponse response model =
    { model | activities = response }

setCouncilResponse response model =
    { model | council = response }

setFooterResponse response model =
    { model | footer = response }


changeEditRoute : Models.EditRoute -> Model -> Model
changeEditRoute route model =
    let
        editModel = model.edit            
    in
        { model | edit = { editModel | route = route } }



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



editResponse : Msgs.EditResponse -> Model -> Model
editResponse response model = 
    case response of
        Msgs.PostResponse x ->
            onResult x model
        Msgs.MemberResponse x ->
            onResult x model
        Msgs.StaticResponse x ->
            onResult x model


onResult httpResult model =
    case httpResult of
        Err e
            -> model
                |> changeAlertMsg ("[ERROR] -> " ++ (toString e)) (model.edit)
        Ok r
            -> model
                |> changeAlertMsg "Successfully Added/Modified :-)" (model.edit)
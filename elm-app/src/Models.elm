module Models exposing (..)
import RemoteData exposing (WebData)
import Http

type alias Model =
    { route : Route
    , home : WebData (HomeModel)
    , members : WebData (MembersModel)
    , activities : WebData (ActivitiesModel)
    , council : WebData (SubCouncilModel)
    , footer : WebData (FooterModel)
    , feedback : FeedbackModel
    }

type alias Post =
    { title : String
    , content : String
    , link : String
    , image : String
    }

type alias HomeModel = 
    { content : List Post
    , directorQuote : Paragraph
    , directorName : String
    , imageBig : Url
    }

type alias Member =
    { name : String 
    , type_ : String
    , email : String
    , contact : String
    , image : String
    , position : String
    }

type alias SubCouncilModel =
    { content : List Post
    , image : String
    , team : List Member
    }

type alias FooterPost =
    { title : String
    , content : List String
    }

type alias FeedbackFormModel =
    { name : String
    , email : String
    , message : String 
    }

type alias FeedbackResponseModel =
    { status : Bool 
    , message : String
    }

type alias FeedbackModel =
    { form : FeedbackFormModel
    , response : Maybe (Result Http.Error FeedbackResponseModel)
    }


type alias FooterModel = List FooterPost
type alias MembersModel = List Member
type alias ActivitiesModel = List Post


initialHomeModel = RemoteData.Loading
initialMembersModel = RemoteData.Loading
initialActivitiesModel = RemoteData.Loading
initialSubCouncilModel = RemoteData.Loading
initialFooterModel = RemoteData.Loading
initialFeedbackModel = FeedbackModel (FeedbackFormModel "" "" "") (Nothing)


type alias Paragraph = String
type alias Url = String

initialModel : Route -> Model
initialModel route =
    { route = route
    , home = initialHomeModel
    , members = initialMembersModel
    , activities = initialActivitiesModel
    , council = initialSubCouncilModel
    , footer = initialFooterModel
    , feedback = initialFeedbackModel
    }

type Route
    = HomeRoute
    | MembersRoute
    | ActivityRoute String
    | SubCouncilRoute String
    | FeedbackRoute
    | NotFoundRoute

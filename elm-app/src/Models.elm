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
    , display : DisplayMode
    , edit : EditModel
    }

type alias Post =
    { title : String
    , content : List String
    , link : String
    , image : String
    , position : Float
    , id : Int
    , page : String
    }

type alias HomeModel = 
    { content : List Post
    , directorQuote : Paragraph
    , directorName : String
    , imageBig : Url
    , directorQuoteId : Int
    , directorNameId : Int
    , imageBigId : Int
    }

type alias Member =
    { name : String 
    , type_ : String
    , email : String
    , contact : String
    , image : String
    , position : String
    , id : Int
    , page : String
    }

type alias SubCouncilModel =
    { content : List Post
    , image : String
    , team : List Member
    }

type alias FeedbackFormModel =
    { name : String
    , email : String
    , message : String 
    }

type alias BasicResponseModel =
    { status : Bool 
    , message : String
    }

type alias FeedbackModel =
    { form : FeedbackFormModel
    , response : Maybe (Result Http.Error BasicResponseModel)
    }

type alias StaticModel =
    { key : String
    , value : String
    }

type alias FooterModel = List Post
type alias MembersModel = List Member
type alias ActivitiesModel = List Post


initialHomeModel = RemoteData.Loading
initialMembersModel = RemoteData.Loading
initialActivitiesModel = RemoteData.Loading
initialSubCouncilModel = RemoteData.Loading
initialFooterModel = RemoteData.Loading
initialFeedbackModel = FeedbackModel (FeedbackFormModel "" "" "") (Nothing)
initialDisplayMode = EditMode 

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
    , display = initialDisplayMode
    , edit = initiaEditModel
    }

type Route
    = HomeRoute
    | MembersRoute
    | ActivityRoute String
    | SubCouncilRoute String
    | FeedbackRoute
    | NotFoundRoute

type DisplayMode
    = EditMode
    | ViewMode

type EditRoute
    = EditPostRoute
    | EditMemberRoute
    | EditStaticRoute

type alias EditModel =
    { route : EditRoute
    , newPost : Post
    , newMember : Member
    , response : Maybe (Result Http.Error BasicResponseModel)
    , alert : String
    }

initiaEditModel =
    { route = EditPostRoute
    , newPost = Post "" [] "" "" 10 -1 "home"
    , newMember = Member "" "student" "" "" "" "" -1 "members"
    , response = Nothing
    , alert = "Notifications displayed here :-)"
    }
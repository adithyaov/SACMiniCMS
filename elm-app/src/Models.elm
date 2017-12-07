module Models exposing (..)
import RemoteData exposing (WebData)


type alias Model =
    { route : Route
    , home : WebData (HomeModel)
    , members : WebData (MembersModel)
    }

type alias Post =
    { title : String
    , content : String
    , meta : String
    , id : Int
    }

type alias HomeModel = 
    { about : List Paragraph
    , directorQuote : Paragraph
    , directorName : String
    , imageBig : Url
    , imageLeft : Url
    , imageMiddle : Url
    , imageRight : Url
    }

type alias Member =
    { name : String 
    , type_ : String
    , email : String
    , contact : String
    , image : String
    , position : String
    }

type alias MembersModel = List Member

initialHomeModel = RemoteData.Loading
initialMembersModel = RemoteData.Loading

type alias Paragraph = String
type alias Url = String

initialModel : Route -> Model
initialModel route =
    { route = route
    , home = initialHomeModel
    , members = initialMembersModel
    }

type Route
    = HomeRoute
    | MembersRoute
    | ActivityRoute String
    | SubCouncilRoute String
    | NotFoundRoute

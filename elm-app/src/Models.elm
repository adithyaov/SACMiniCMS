module Models exposing (..)
import RemoteData exposing (WebData)


type alias Model =
    { route : Route
    , home : WebData (HomeModel)
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

initialHomeModel = RemoteData.Loading

type alias Paragraph = String
type alias Url = String

initialModel : Route -> Model
initialModel route =
    { route = route
    , home = initialHomeModel
    }

type Route
    = HomeRoute
    | ActivityRoute String
    | SubCouncilRoute String
    | NotFoundRoute

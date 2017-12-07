module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map HomeRoute (s "members")
        , map ActivityRoute (s "activities" </> string)
        , map SubCouncilRoute (s "sub-council" </> string)
        , map HomeRoute (s "feedback")
        , map HomeRoute (s "links")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            conditionRoute route

        Nothing ->
            NotFoundRoute


conditionRoute : Route -> Route
conditionRoute route =
    case route of
        ActivityRoute route -> if List.member route validActivities then ActivityRoute route else NotFoundRoute
        SubCouncilRoute route -> if List.member route validCouncils then SubCouncilRoute route else NotFoundRoute
        _ -> route

validActivities : List String
validActivities = ["technical", "cultural", "social", "sports", "other"]

validCouncils : List String
validCouncils = ["sports", "technical", "cultural"]
module Route exposing (Route(..), fromUrl, href, replaceUrl, pushUrl)

import Browser.Navigation as Nav
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)


-- ROUTING


type Route
    = Root
    | ModuleADashboard
    | ModuleAAnalytics
    | ModuleAReports
    | ModuleBOverview
    | ModuleBDetails
    | ModuleBSettings
    | ModuleCHome
    | ModuleCProfile
    | ModuleCPreferences


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Root Parser.top
        , Parser.map ModuleADashboard (s "module-a" </> s "dashboard")
        , Parser.map ModuleAAnalytics (s "module-a" </> s "analytics")
        , Parser.map ModuleAReports (s "module-a" </> s "reports")
        , Parser.map ModuleBOverview (s "module-b" </> s "overview")
        , Parser.map ModuleBDetails (s "module-b" </> s "details")
        , Parser.map ModuleBSettings (s "module-b" </> s "settings")
        , Parser.map ModuleCHome (s "module-c" </> s "home")
        , Parser.map ModuleCProfile (s "module-c" </> s "profile")
        , Parser.map ModuleCPreferences (s "module-c" </> s "preferences")
        ]



-- PUBLIC HELPERS


href : Route -> Attribute msg
href targetRoute =
    Attr.href (routeToString targetRoute)


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    Parser.parse parser url



-- INTERNAL


routeToString : Route -> String
routeToString page =
    "/" ++ String.join "/" (routeToPieces page)


routeToPieces : Route -> List String
routeToPieces page =
    case page of
        Root ->
            []

        ModuleADashboard ->
            [ "module-a", "dashboard" ]

        ModuleAAnalytics ->
            [ "module-a", "analytics" ]

        ModuleAReports ->
            [ "module-a", "reports" ]

        ModuleBOverview ->
            [ "module-b", "overview" ]

        ModuleBDetails ->
            [ "module-b", "details" ]

        ModuleBSettings ->
            [ "module-b", "settings" ]

        ModuleCHome ->
            [ "module-c", "home" ]

        ModuleCProfile ->
            [ "module-c", "profile" ]

        ModuleCPreferences ->
            [ "module-c", "preferences" ]

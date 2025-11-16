module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, header, nav, span, text, ul, li, a)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


-- MODEL


type alias Model =
    { modules : List Module
    , activeModule : ModuleId
    , activePage : PageId
    , isModuleSwitcherOpen : Boolean
    }


type alias Module =
    { id : ModuleId
    , name : String
    , pages : List Page
    }


type alias Page =
    { id : PageId
    , name : String
    }


type ModuleId
    = ModuleA
    | ModuleB
    | ModuleC


type PageId
    = PageId String


init : Model
init =
    { modules =
        [ { id = ModuleA
          , name = "Module A"
          , pages =
                [ { id = PageId "dashboard", name = "Dashboard" }
                , { id = PageId "analytics", name = "Analytics" }
                , { id = PageId "reports", name = "Reports" }
                ]
          }
        , { id = ModuleB
          , name = "Module B"
          , pages =
                [ { id = PageId "overview", name = "Overview" }
                , { id = PageId "details", name = "Details" }
                , { id = PageId "settings", name = "Settings" }
                ]
          }
        , { id = ModuleC
          , name = "Module C"
          , pages =
                [ { id = PageId "home", name = "Home" }
                , { id = PageId "profile", name = "Profile" }
                , { id = PageId "preferences", name = "Preferences" }
                ]
          }
        ]
    , activeModule = ModuleA
    , activePage = PageId "dashboard"
    , isModuleSwitcherOpen = False
    }


-- UPDATE


type Msg
    = ToggleModuleSwitcher
    | SelectModule ModuleId
    | SelectPage PageId


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleModuleSwitcher ->
            { model | isModuleSwitcherOpen = not model.isModuleSwitcherOpen }

        SelectModule moduleId ->
            let
                firstPage =
                    model.modules
                        |> List.filter (\m -> m.id == moduleId)
                        |> List.head
                        |> Maybe.andThen (\m -> List.head m.pages)
                        |> Maybe.map .id
                        |> Maybe.withDefault (PageId "")
            in
            { model
                | activeModule = moduleId
                , activePage = firstPage
                , isModuleSwitcherOpen = False
            }

        SelectPage pageId ->
            { model | activePage = pageId }


-- VIEW


view : Model -> Html Msg
view model =
    div [ class "min-h-screen bg-gray-100 flex flex-col" ]
        [ viewHeader model
        , div [ class "flex flex-1" ]
            [ viewSidebar model
            , viewMainContent model
            ]
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    header [ class "bg-white border-b border-gray-200 px-6 py-4" ]
        [ div [ class "flex items-center justify-between" ]
            [ div [ class "flex items-center space-x-4" ]
                [ viewModuleSwitcher model
                , viewBreadcrumbs model
                ]
            ]
        ]


viewModuleSwitcher : Model -> Html Msg
viewModuleSwitcher model =
    div [ class "relative" ]
        [ button
            [ class "flex items-center space-x-3 px-4 py-2 bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors"
            , onClick ToggleModuleSwitcher
            ]
            [ -- Bars icon (hamburger menu)
              div [ class "w-6 h-6 flex flex-col justify-center space-y-1.5" ]
                [ div [ class "w-full h-0.5 bg-gray-700" ] []
                , div [ class "w-full h-0.5 bg-gray-700" ] []
                , div [ class "w-full h-0.5 bg-gray-700" ] []
                ]
            , span [ class "font-semibold text-gray-800" ]
                [ text (getModuleName model.activeModule) ]
            , -- Dropdown arrow
              div [ class "text-gray-500" ]
                [ if model.isModuleSwitcherOpen then
                    text "▲"
                  else
                    text "▼"
                ]
            ]
        , if model.isModuleSwitcherOpen then
            viewModuleDropdown model
          else
            text ""
        ]


viewModuleDropdown : Model -> Html Msg
viewModuleDropdown model =
    div [ class "absolute top-full left-0 mt-2 w-64 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-50" ]
        [ ul [ class "space-y-1" ]
            (List.map (viewModuleOption model.activeModule) model.modules)
        ]


viewModuleOption : ModuleId -> Module -> Html Msg
viewModuleOption activeModuleId module_ =
    li []
        [ button
            [ class <|
                "w-full text-left px-4 py-2 hover:bg-gray-100 transition-colors "
                    ++ (if activeModuleId == module_.id then
                            "bg-blue-50 text-blue-700 font-semibold"
                        else
                            "text-gray-700"
                       )
            , onClick (SelectModule module_.id)
            ]
            [ text module_.name ]
        ]


viewBreadcrumbs : Model -> Html Msg
viewBreadcrumbs model =
    let
        currentModule = getModuleName model.activeModule
        currentPage = getPageName model.activePage model
    in
    nav [ class "flex items-center space-x-2 text-sm text-gray-600" ]
        [ span [ class "font-medium text-gray-800" ] [ text currentModule ]
        , span [] [ text "/" ]
        , span [ class "text-gray-600" ] [ text currentPage ]
        ]


viewSidebar : Model -> Html Msg
viewSidebar model =
    nav [ class "w-64 bg-white border-r border-gray-200 p-4" ]
        [ div [ class "mb-4" ]
            [ h1 [ class "text-lg font-bold text-gray-800 px-3" ]
                [ text "Pages" ]
            ]
        , ul [ class "space-y-1" ]
            (getCurrentModulePages model
                |> List.map (viewPageItem model.activePage)
            )
        ]


viewPageItem : PageId -> Page -> Html Msg
viewPageItem activePageId page =
    li []
        [ button
            [ class <|
                "w-full text-left px-3 py-2 rounded-lg transition-colors "
                    ++ (if activePageId == page.id then
                            "bg-blue-500 text-white font-semibold"
                        else
                            "text-gray-700 hover:bg-gray-100"
                       )
            , onClick (SelectPage page.id)
            ]
            [ text page.name ]
        ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    div [ class "flex-1 p-8" ]
        [ div [ class "bg-white rounded-lg shadow-md p-8" ]
            [ h1 [ class "text-3xl font-bold text-gray-800 mb-4" ]
                [ text (getModuleName model.activeModule) ]
            , div [ class "text-xl text-gray-600" ]
                [ text ("Current Page: " ++ getPageName model.activePage model) ]
            , div [ class "mt-8 p-6 bg-gray-50 rounded-lg" ]
                [ text "Your page content goes here..." ]
            ]
        ]


-- HELPERS


getModuleName : ModuleId -> String
getModuleName moduleId =
    case moduleId of
        ModuleA ->
            "Module A"

        ModuleB ->
            "Module B"

        ModuleC ->
            "Module C"


getCurrentModulePages : Model -> List Page
getCurrentModulePages model =
    model.modules
        |> List.filter (\m -> m.id == model.activeModule)
        |> List.head
        |> Maybe.map .pages
        |> Maybe.withDefault []


getPageName : PageId -> Model -> String
getPageName (PageId pageIdStr) model =
    getCurrentModulePages model
        |> List.filter (\p -> p.id == PageId pageIdStr)
        |> List.head
        |> Maybe.map .name
        |> Maybe.withDefault pageIdStr

module Main exposing (main)

import Browser
import Html exposing (Html, div, h1, p, text)
import Html.Attributes exposing (class)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


view : Model -> Html Msg
view model =
    div [ class "min-h-screen bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center" ]
        [ div [ class "bg-white rounded-lg shadow-2xl p-8 max-w-md" ]
            [ h1 [ class "text-4xl font-bold text-gray-800 mb-4" ]
                [ text "Hello, Elm + Tailwind!" ]
            , p [ class "text-gray-600 text-lg" ]
                [ text "Your project is set up and ready to go. Start building amazing things!" ]
            ]
        ]

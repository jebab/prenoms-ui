module View exposing (Model, Msg(..), PrenomState(..), view)

import Html exposing (..)
import Http exposing (Error(..))
import Model.Prenoms as Prenoms exposing (PrenomGetResult, Prenoms)


type Msg
    = LoadPrenoms
    | GotPrenoms PrenomGetResult


type PrenomState
    = Loading
    | Idle
    | LoadError Http.Error



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { prenoms : Maybe Prenoms
    , state : PrenomState
    }



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    let
        header =
            Html.header [] []

        nav =
            Html.nav [] []

        main_ =
            Html.main_ []
                [ case model.prenoms of
                    Nothing ->
                        Html.text "Auun prénom trouvé ?"

                    Just data ->
                        Prenoms.toHtml data
                ]

        footer =
            Html.footer []
                [ case model.state of
                    LoadError err ->
                        Html.text <| httpErrorToString err

                    _ ->
                        Html.div [] []
                ]
    in
    div []
        [ header
        , nav
        , main_
        , footer
        ]


httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        BadUrl url ->
            "BadUrl: " ++ url

        Timeout ->
            "Timeout"

        NetworkError ->
            "NetworkError"

        BadStatus _ ->
            "BadStatus"

        BadBody s ->
            "BadBody: " ++ s

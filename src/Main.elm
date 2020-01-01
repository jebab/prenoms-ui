port module Main exposing (init, main, toJs, update)

import Browser
import Http exposing (Error(..))
import Model.Prenoms as Prenoms exposing (PrenomGetResult, Prenoms)
import View exposing (Model, Msg(..), PrenomState(..))



-- ---------------------------
-- PORTS
-- ---------------------------


port toJs : String -> Cmd msg


init : Int -> ( Model, Cmd Msg )
init flags =
    ( { prenoms = Nothing
      , state = Loading
      }
    , Prenoms.getPrenoms GotPrenoms
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LoadPrenoms ->
            ( { model | state = Loading }
            , Prenoms.getPrenoms GotPrenoms
            )

        GotPrenoms result ->
            case result of
                Ok data ->
                    ( { model | prenoms = Just data, state = Idle }, Cmd.none )

                Err err ->
                    ( { model | state = LoadError err }, Cmd.none )



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program Int Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "Prénoms"
                , body = [ View.view m ]
                }
        , subscriptions = \_ -> Sub.none
        }

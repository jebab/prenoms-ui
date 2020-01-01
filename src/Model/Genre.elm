module Model.Genre exposing (Genre(..), decode, toHtml, toString)

import Html exposing (..)
import Json.Decode as Decode


type Genre
    = Masculin
    | Feminin


toHtml : Genre -> Html msg
toHtml genre =
    toString genre
        |> Html.text


toString : Genre -> String
toString genre =
    case genre of
        Masculin ->
            "Masculin"

        Feminin ->
            "Feminin"


decode : Decode.Decoder Genre
decode =
    Decode.string
        |> Decode.andThen
            (\str ->
                case str of
                    "Masculin" ->
                        Decode.succeed Masculin

                    "Feminin" ->
                        Decode.succeed Feminin

                    _ ->
                        Decode.fail ("Unknown val : " ++ str)
            )

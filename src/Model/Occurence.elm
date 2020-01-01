module Model.Occurence exposing (Occurence, decode, toHtml, toString)

import Html exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type alias Occurence =
    { annee : Int
    , nombre : Int
    }


toHtml : Occurence -> Html msg
toHtml occurence =
    Html.article []
        [ Html.text <| toString occurence ]


toString : Occurence -> String
toString occurence =
    String.fromInt occurence.annee ++ " (" ++ String.fromInt occurence.nombre ++ ")"


decode : Decode.Decoder Occurence
decode =
    Decode.succeed Occurence
        |> Pipeline.required "annee" Decode.int
        |> Pipeline.required "nombre" Decode.int

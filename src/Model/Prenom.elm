module Model.Prenom exposing (Prenom, decode, toHtml)

import Html exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import Model.Genre as Genre exposing (Genre)


type alias Prenom =
    { prenom : String
    , genre : Genre
    }


toHtml : Prenom -> Html msg
toHtml prenom =
    Html.section []
        [ Html.h1 [] [ Html.text prenom.prenom ]
        ]


decode : Decode.Decoder Prenom
decode =
    Decode.succeed Prenom
        |> Pipeline.required "prenom" Decode.string
        |> Pipeline.required "genre" Genre.decode

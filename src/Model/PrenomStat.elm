module Model.PrenomStat exposing (PrenomStat, decode, toHtml)

import Html exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import Model.Genre as Genre
import Model.Occurence as Occurence exposing (Occurence)
import Model.Prenom as Prenom exposing (Prenom)


type alias PrenomStat =
    { derniereAnnee : Occurence
    , premiereAnnee : Occurence
    , meilleurAnnee : Occurence
    , occurences : List Occurence
    , prenom : Prenom
    }


decode : Decode.Decoder PrenomStat
decode =
    Decode.succeed PrenomStat
        |> Pipeline.required "derniereAnnee" Occurence.decode
        |> Pipeline.required "premiereAnnee" Occurence.decode
        |> Pipeline.required "meilleurAnnee" Occurence.decode
        |> Pipeline.required "occurences" (Decode.list Occurence.decode)
        |> Pipeline.required "prenom" Prenom.decode


toHtml : PrenomStat -> Html msg
toHtml prenom =
    Html.article []
        [ Prenom.toHtml prenom.prenom
        , Html.footer []
            [ Html.h5 []
                [ Html.text <|
                    Genre.toString prenom.prenom.genre
                        ++ ". "
                        ++ "Donné entre "
                        ++ Occurence.toString prenom.premiereAnnee
                        ++ " et "
                        ++ Occurence.toString prenom.derniereAnnee
                        ++ ". "
                , Html.text <| "Son année la plus populaire est " ++ Occurence.toString prenom.meilleurAnnee ++ "."
                ]
            ]
        ]

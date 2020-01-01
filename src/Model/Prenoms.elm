module Model.Prenoms exposing (PrenomGetResult, Prenoms, getPrenoms, toHtml)

import Html exposing (..)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import Model.PrenomStat as PrenomStat exposing (PrenomStat)


type alias Prenoms =
    { loadTime : Int
    , resultat : List PrenomStat
    }


type alias PrenomGetResult =
    Result Http.Error Prenoms


toHtml : Prenoms -> Html msg
toHtml prenoms =
    [ List.map PrenomStat.toHtml prenoms.resultat
    , [ Html.footer [] [ Html.text <| "Chargé en " ++ String.fromInt prenoms.loadTime ] ]
    ]
        |> List.concat
        |> Html.section
            []


decode : Decode.Decoder Prenoms
decode =
    Decode.succeed Prenoms
        |> Pipeline.required "loadTime" Decode.int
        |> Pipeline.required "resultat" (Decode.list PrenomStat.decode)


getPrenoms : (PrenomGetResult -> msg) -> Cmd msg
getPrenoms toMsg =
    Http.get { url = "/api/prenoms?nb=10", expect = Http.expectJson toMsg decode }

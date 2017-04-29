module Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

init page =
    let
        basics =
            [ meta
            , (getStyle "http://byrdstyle.io")
            , (getStyle "./index.css")
            , (getStyle "./modal.css")
            ]
    in
        List.append basics page

meta =
    let
        attrs =
            [ name "viewport"
            , content "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
            ]
    in
        node "meta" attrs []

getStyle location =
    let
        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" location
            ]
    in
        node "link" attrs []
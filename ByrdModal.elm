module ByrdModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute)
import Html.Events exposing (onClick)

type alias ByrdModalModel =
    { title : String
    , content : String
    , active : Bool
    , death : String
    , interval : Int
    }

byrdModalModel: String -> String -> Bool -> ByrdModalModel
byrdModalModel title content active =
    { title = title
    , content = content
    , active = active
    , death = ""
    , interval = 0
    }

byrdModalTick : ByrdModalModel -> ByrdModalModel
byrdModalTick model =
    if ( (String.length model.death) > 0 ) then
        { model | interval = model.interval + 1 }
        |> byrdModalDeath
    else
        model

byrdModalClose : ByrdModalModel -> ByrdModalModel
byrdModalClose model = { model | death = " death" }

byrdModalOpen : ByrdModalModel -> ByrdModalModel
byrdModalOpen model = { model | active = True, death = "", interval = 0 }

byrdModalDeath model =
    if ((String.length model.death) > 0) then
            if model.interval > 800 then
                { model | death = "", interval = 0 , active = False }
            else
                model
    else
        model

byrdModal modal close =
    if modal.active then
        div [ attribute "class" ( "byrd-modal-bg active" ) ]
              [ section [ attribute "class" ( "byrd-modal" ++ modal.death ) ]
                  [ h1 [ attribute "class" "center" ] [ text modal.title ]
                  , hr [] []
                  , div [ attribute "class" "center" ]
                      [ p [] [ text modal.content ]
                      ]
                  , hr [] []
                  , button [ attribute "class" "flat-btn primary", onClick close ] [ text "Play" ]
                  ]
              ]
    else
        div [] []
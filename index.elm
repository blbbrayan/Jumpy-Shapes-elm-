module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Utils as Utils
import Collage exposing (..)
import GameObject exposing (..)
import Color as Color
import Element as Element
import Time exposing (..)
import GameUI exposing (..)

main =
    Html.program
    { init = init
    , update = \msg m -> update msg m ! []
    , view = view
    , subscriptions = subscriptions
    }

--init

init : (Model, Cmd Msg)
init = (model, Cmd.none)

--subscription

subscriptions model =
    Time.every Time.millisecond Tick

--model

type alias Model =
    { player: GameObject
    , pipes: List GameObject
    , interval: Int
    , menu: ByrdModalModel
    }

model : Model
model =
    { player = gameObject 100 20 50 50 Color.yellow
    , pipes = []
    , interval = 0
    , menu = byrdModalModel "Jumpy Shapes" "Welcome to Jumpy Shapes the demo! Made \"Purely\" with elm" True
    }

movePlayer : Model -> Model
movePlayer model =
    if model.player.yVel < 8 then
        { model | player = accelerate model.player 0 0.1 }
    else
        model

resetPlayer player = { player | bounds = { x = 100, y = 20, width = 50, height = 50}}

--update

type Msg = Jump | Tick Time | CloseModal

update msg model =
    case msg of
        Jump ->
            { model | player = accelerate model.player 0 -8 }
        Tick delta ->
            { model | interval = model.interval + 1}
            |> checkInterval
        CloseModal ->
            { model | menu = byrdModalClose model.menu, player =  resetPlayer model.player}

checkInterval model =
    if model.interval >= round 10 then
        { model | player = moveGO model.player, interval = 0, menu = (byrdModalTick model.menu) }
    else
       model
    |> movePlayer

--view

view model =
    let
        gameWidth = 800
        gameHeight = 600
    in
        div [ onClick Jump, (attribute "class" "game") ]
        (Utils.init <|
        [ collage gameWidth gameHeight
              [ rect gameWidth gameHeight
                  |> filled Color.blue
              , toShape model.player False
                  |> filled model.player.color
                  |> move ( -( gameWidth / 2 ) + model.player.bounds.x, ( gameHeight / 2 ) - model.player.bounds.y )
              ]
              |> Element.toHtml
        , byrdModal model.menu CloseModal
        ]
        )
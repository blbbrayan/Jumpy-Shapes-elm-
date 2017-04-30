import GameTypes exposing (Model, Seed)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Utils as Utils
import Collage exposing (..)
import GameObject exposing (..)
import Color as Color
import Element as Element
import Time exposing (..)

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

model : Model
model =
    { player = gameObject 100 550 50 50 Color.yellow
    , pipes = []
    , interval = 0
    , spawnTimer = 0
    , menu = byrdModalModel "Jumpy Shapes" "Welcome to Jumpy Shapes the demo! Made \"Purely\" with elm" False
    , seed = randomSeed
    }

movePlayer : Model -> Model
movePlayer model =
    if model.player.yVel < 15 then
        { model | player = accelerate model.player 0 0.15 }
    else
        model

resetPlayer player = { player | bounds = { x = 100, y = 20, width = 50, height = 50}}

checkDeath : Model -> Model
checkDeath model =
    if model.player.bounds.y > 550 then
        { model | menu = byrdModalOpen model.menu }
    else
        model

spawn : Model -> Model
spawn model =
    if model.spawnTimer > 900 then
        { model | seed = (subSeed model.seed), pipes = ( ( spawnPipe model ) :: model.pipes ), spawnTimer = 0 }
    else
        { model | spawnTimer = model.spawnTimer + 1 }

--update

type Msg = Jump | Tick Time | CloseModal

update msg model =
    case msg of
        Jump ->
            { model | player = accelerate model.player 0 -10 }
        Tick delta ->
            { model | interval = model.interval + 1, spawnTimer = model.spawnTimer + 1}
            |> checkInterval
        CloseModal ->
            { model | menu = byrdModalClose model.menu, player =  resetPlayer model.player}

checkInterval model =
    if model.interval >= round 10 then
        { model | player = moveGO model.player, interval = 0, menu = (byrdModalTick model.menu), pipes = (List.map moveGO model.pipes), seed = checkSeed model.seed }
    else
       model
    |> movePlayer
    |> checkDeath
    |> spawn

checkSeed : Seed -> Seed
checkSeed seed =
    if List.length seed.seed <= 0 then
        randomSeed
    else
        seed


--view

view model =
    let
        gameWidth = 800
        gameHeight = 600
    in
        div [ onClick Jump, (attribute "class" "game") ]
        (Utils.init <|
        [ h1 [ attribute "style" "color: white;" ] [ Html.text ( toString (model.seed.seed) ) ]
        , collage gameWidth gameHeight
              (List.append
                  [ rect gameWidth gameHeight
                      |> filled Color.blue
                  , toShape model.player False
                      |> filled model.player.color
                      |> move ( -( gameWidth / 2 ) + model.player.bounds.x, ( gameHeight / 2 ) - model.player.bounds.y )
                  ]
                  (List.map toShapePipe model.pipes))
              |> Element.toHtml
        , byrdModal model.menu CloseModal
        ]
        )

toShapePipe a =
    toShape a True
    |> filled a.color
    |> move ( -( 400 ) + a.bounds.x, ( 300 ) - a.bounds.y )
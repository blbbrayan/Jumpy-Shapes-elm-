module GamePipe exposing (..)

import Color
import GameObject exposing (..)
import GameTypes exposing (..)

setSpeed : GameObject -> GameObject
setSpeed gameObject = { gameObject | xVel = -10}

randomSeed : Seed
randomSeed = { seed = [ 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1  ] }

subSeed : Seed -> Seed
subSeed ranSeed = { ranSeed | seed = (List.drop 1 ranSeed.seed) }

spawnPipe : Model -> GameObject
spawnPipe model =
    let
        ranSeen = model.seed
    in
        case ( List.head ranSeen.seed ) of
            Just a ->
                if a == 1 then
                    gameObject 800 0 100 450 Color.green
                    |> setSpeed
                else
                    gameObject 800 550 100 450 Color.green
                    |> setSpeed
            Nothing ->
                gameObject 800 0 100 450 Color.green
                |> setSpeed
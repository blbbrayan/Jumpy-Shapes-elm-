module GameTypes exposing (..)

import ByrdModal exposing (ByrdModalModel)
import Color exposing (Color)

type alias Bounds =
    { x: Float
    , y: Float
    , width: Float
    , height: Float
    }

type alias GameObject =
    { bounds: Bounds
    , color: Color
    , xVel: Float
    , yVel: Float
    }

type alias Model =
    { player: GameObject
    , pipes: List GameObject
    , interval: Int
    , spawnTimer: Int
    , menu: ByrdModalModel
    , seed: Seed
    , running: Bool
    }

type alias Seed =
    { seed : List Int
    }


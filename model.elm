module Model exposing (..)

import GameObject exposing (GameObject)
import GameUI exposing (ByrdModalModel)
import Seed exposing (Seed)

type alias Model =
    { player: GameObject
    , pipes: List GameObject
    , interval: Int
    , spawnTimer: Int
    , menu: ByrdModalModel
    , seed: Seed
    }
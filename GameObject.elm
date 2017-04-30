module GameObject exposing (..)

import Collage exposing (..)
import Color exposing (..)
import GameTypes exposing (GameObject)

gameObject: Float -> Float -> Float -> Float -> Color -> GameObject
gameObject x y width height color =
    { bounds =
        { x = x
        , y = y
        , width = width
        , height = height
        }
    , color = color
    , xVel = 0
    , yVel = 0
    }

accelerate : GameObject -> Float -> Float -> GameObject
accelerate gameObject valx valy = { gameObject | xVel = gameObject.xVel + valx, yVel = gameObject.yVel + valy}

moveGO : GameObject -> GameObject
moveGO gameObject =
    let
        bounds = gameObject.bounds
    in
        if bounds.y > 550 then
            gameObject
        else if bounds.y < 0 then
            { gameObject | bounds = {bounds | x = bounds.x + gameObject.xVel, y = 0}, yVel = 0 }
        else
            { gameObject | bounds = {bounds | x = bounds.x + gameObject.xVel, y = bounds.y + gameObject.yVel} }

toShape : GameObject -> Bool -> Shape
toShape obj isRect =
    if isRect == True then
        rect obj.bounds.width obj.bounds.height
    else
        oval obj.bounds.width obj.bounds.height
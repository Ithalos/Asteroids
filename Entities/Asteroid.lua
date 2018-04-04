--[[
    File: Asteroid.lua
    Author: Sam Triest

    Defines the blueprint for asteroids, and their operations.
]]

Asteroid =
{
    image,
    position,
    direction,
    rotation,
    speed,
    size,
    offset,
    collisionRadius
}

--[[
    Contains all asteroids.
]]
local asteroids = {}


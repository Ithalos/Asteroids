--[[
    File: Asteroid.lua
    Author: Sam Triest

    Defines the blueprint for asteroids, and their operations.
]]

Asteroid =
{
    mesh,
    position,
    velocity,
    direction,
    speed,
    size,
    collisionRadius
}

--[[
    Contains all asteroids.
]]
local asteroids = {}


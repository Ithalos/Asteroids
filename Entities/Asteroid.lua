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

--[[
    Load Asteroid images.
]]
local shapes = {}
shapes[1] = love.graphics.newImage("Resources/Images/Asteroid_1.png")
shapes[2] = love.graphics.newImage("Resources/Images/Asteroid_2.png")
shapes[3] = love.graphics.newImage("Resources/Images/Asteroid_3.png")


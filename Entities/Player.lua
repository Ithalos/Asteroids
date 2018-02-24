--[[
    File: Player.lua
    Author: Sam Triest

    The Player class defines the blueprint for the player's ship,
    and its operations.
]]

Player =
{
    mesh,
    position,
    rotation,
    rotationSpeed,
    velocity,
    direction,
    friction,
    speed,
    speedCutoff
}

--[[
    Creates and returns a new Player object.
]]
function Player:New(mesh, position, rotationSpeed, friction, speed, speedCutoff)
    newPlayer = {}
    setmetatable(newPlayer, self)
    self.__index = self
    newPlayer.mesh = mesh
    newPlayer.position = position
    newPlayer.rotation = 0
    newPlayer.rotationSpeed = rotationSpeed
    newPlayer.velocity = Vector2:New(0, 0)
    newPlayer.direction = Vector2:New(0, 0)
    newPlayer.friction = friction
    newPlayer.speed = speed
    newPlayer.speedCutoff = speedCutoff
    return newPlayer
end


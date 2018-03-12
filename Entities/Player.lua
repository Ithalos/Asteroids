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
    speedCutoff,
    centreOffset,
    collisionRadius
}

--[[
    Creates and returns a new Player object.
]]
function Player:New(vertices, position)
    newPlayer = {}
    setmetatable(newPlayer, self)
    self.__index = self

    newPlayer.mesh = love.graphics.newMesh(vertices, "fan", "dynamic")

    newPlayer.position = position
    newPlayer.velocity = Vector2:New()
    newPlayer.direction = Vector2:New()

    newPlayer.rotation = 0
    newPlayer.rotationSpeed = 3

    newPlayer.friction = 0.15
    newPlayer.speed = 500
    newPlayer.speedCutoff = 0.0005

    return newPlayer
end

--[[
    Sets up circle-to-circle collision settings for the player's ship.
    This will hopefully be replaced with a more precise system at a later date.
]]
function Player:CircleCollisionSetup(centreOffset, collisionRadius)
    self.centreOffset = centreOffset
    self.collisionRadius = collisionRadius
end

--[[
    Renders the Player to the screen. Call this method in love.draw().
]]
function Player:Render()
    love.graphics.draw(self.mesh, self.position.x, self.position.y, self.rotation, 1, 1,
                       self.centreOffset.x, self.centreOffset.y)
end


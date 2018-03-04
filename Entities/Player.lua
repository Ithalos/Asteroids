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
function Player:New(vertices, position, rotationSpeed, friction, speed, speedCutoff)
    newPlayer = {}
    setmetatable(newPlayer, self)
    self.__index = self
    newPlayer.mesh = love.graphics.newMesh(vertices, "fan", "dynamic")
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


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
    collisionRadius
}

--[[
    The vertices that make up the player's ship.
]]
local vertices =
{
    {-25, -15, 1, 1, 255,255,255,255},
    { 25,   0, 1, 1, 255,255,255,255},
    {-25,  15, 1, 1, 255,255,255,255}
}

--[[
    Creates and returns a new Player object.
]]
function Player:New(position)
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
    Moves the player's ship.
]]
function Player:Move(dt)
    self.direction.x = math.cos(self.rotation)
    self.direction.y = math.sin(self.rotation)
    self.direction:Normalise()

    if love.keyboard.isDown("left") then
        self.rotation = self.rotation - self.rotationSpeed * dt
    elseif love.keyboard.isDown("right") then
        self.rotation = self.rotation + self.rotationSpeed * dt
    end

    if love.keyboard.isDown("up") then
        self.velocity.x = self.velocity.x + self.direction.x * dt
        self.velocity.y = self.velocity.y + self.direction.y * dt
    else
        if self.velocity:Length() > 0 then
            if self.velocity:Length() < self.speedCutoff then
                self.velocity.x = 0
                self.velocity.y = 0
            else
                normalised = Normalise(self.velocity)
                normalised.x = normalised.x * self.friction * dt
                normalised.y = normalised.y * self.friction * dt

                self.velocity.x = self.velocity.x - normalised.x
                self.velocity.y = self.velocity.y - normalised.y
            end
        end
    end

    self.position.x = self.position.x + self.velocity.x * self.speed * dt
    self.position.y = self.position.y + self.velocity.y * self.speed * dt
end

--[[
    Sets up circle-to-circle collision settings for the player's ship.
    This will hopefully be replaced with a more precise system at a later date.
]]
function Player:CircleCollisionSetup(collisionRadius)
    self.collisionRadius = collisionRadius
end

--[[
    Renders the Player to the screen. Call this method in love.draw().
]]
function Player:Render()
    love.graphics.draw(self.mesh,
                       self.position.x, self.position.y, self.rotation,
                       1, 1, 0, 0)
end


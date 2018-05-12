--[[
    File: Player.lua
    Author: Sam Triest

    The Player class defines the blueprint for the player's ship,
    and its operations.
]]

Player =
{
    score,
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
    {-25, -15, 1, 1, 255, 255, 255, 255},
    { 25,   0, 1, 1, 255, 255, 255, 255},
    {-25,  15, 1, 1, 255, 255, 255, 255}
}

--[[
    Creates and returns a new Player object.
]]
function Player:New(position)
    newPlayer = {}
    setmetatable(newPlayer, self)
    self.__index = self

    newPlayer.score = 0

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
    -- Normalise looking direction
    self.direction = Vector2:New(math.cos(self.rotation), math.sin(self.rotation))
    self.direction:Normalise()

    if love.keyboard.isDown("left") then
        self.rotation = self.rotation - self.rotationSpeed * dt
    elseif love.keyboard.isDown("right") then
        self.rotation = self.rotation + self.rotationSpeed * dt
    end

    -- Increase velocity while up arrow is down
    if love.keyboard.isDown("up") then
        self.velocity.x = self.velocity.x + self.direction.x * dt
        self.velocity.y = self.velocity.y + self.direction.y * dt
    else
        if self.velocity:Length() > 0 then
            -- If the ship is moving slower than the cutoff speed, stop moving
            if self.velocity:Length() < self.speedCutoff then
                self.velocity.x = 0
                self.velocity.y = 0

            -- Ship is above the cutoff speed with no user input
            -- Apply friction
            else
                normalised = Normalise(self.velocity)
                normalised.x = normalised.x * self.friction * dt
                normalised.y = normalised.y * self.friction * dt

                self.velocity.x = self.velocity.x - normalised.x
                self.velocity.y = self.velocity.y - normalised.y
            end
        end
    end

    -- Update ship position
    self.position.x = self.position.x + self.velocity.x * self.speed * dt
    self.position.y = self.position.y + self.velocity.y * self.speed * dt

    -- Wrap to the other side of the screen if the player moves past the screen edge
    if self.position.x < -25 then
	self.position.x = WINDOW_W
    elseif self.position.x > WINDOW_W + 25 then
	self.position.x = -25
    end
    if self.position.y < -25 then
	self.position.y = WINDOW_H
    elseif self.position.y > WINDOW_H + 25 then
	self.position.y = -25
    end
end

--[[
    Instantiates a new Projectile object at the player's position, in the
    direction the player is aiming.
]]
function Player:Shoot()
    position = Vector2:New(self.position.x, self.position.y)
    direction = Vector2:New(self.direction.x, self.direction.y)
    direction:Normalise()
    Projectile:New(position, direction)
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

--[[
    Renders the Player's debugging information. Call this method in love.draw().
]]
function Player:RenderDebug()
    -- Circle collision radius
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
end

--[[
    Increases the player's score after shooting an asteroid.
]]
function Player:IncreaseScore(size)
    points = 0

    if size == 1 then
        points = 5
    elseif size == 0.8 then
        points = 15
    else
        points = 25
    end

    self.score = self.score + points
end


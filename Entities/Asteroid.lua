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

--[[
    Creates a new Asteroid object and adds it to the asteroids table.
]]
function Asteroid:New(position)
    newAsteroid = {}
    setmetatable(newAsteroid, self)
    self.__index = self

    -- Select a random shape
    newAsteroid.image = shapes[math.random(1, 3)]

    newAsteroid.position = position
    newAsteroid.direction = Vector2:New(math.random(-10, 10), math.random(-10, 10))
    newAsteroid.direction:Normalise()
    newAsteroid.rotation = math.random(-10, 10)
    newAsteroid.speed = 100

    newAsteroid.size = 1
    newAsteroid.offset = newAsteroid.image:getWidth() / 2

    newAsteroid.collisionRadius = 50

    table.insert(asteroids, newAsteroid)
end

--[[
    Updates the position of an Asteroid object.
]]
function Asteroid:Update(dt)
    self.position.x = self.position.x + self.direction.x * self.speed * dt
    self.position.y = self.position.y + self.direction.y * self.speed * dt
end

--[[
    Renders an Asteroid object to the screen.
]]
function Asteroid:Render()
    love.graphics.draw(self.image, self.position.x, self.position.y,
                       self.rotation, self.size, self.size,
                       self.offset, self.offset)
end

--[[
    Renders an Asteroid's debugging information. Call this method in love.draw().
]]
function Asteroid:RenderDebug()
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
end


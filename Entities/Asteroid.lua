--[[
    File: Asteroid.lua
    Author: Sam Triest

    Defines the blueprint for asteroids, and their operations.
]]

Asteroid =
{
    image,
    scoreValue,
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
function Asteroid:New(x, y)
    asteroid = {}
    setmetatable(asteroid, self)
    self.__index = self

    -- Select a random shape
    asteroid.image = shapes[math.random(1, 3)]

    asteroid.scoreValue = 5

    asteroid.position = Vector2:New(x, y)
    asteroid.direction = Vector2:New(math.random(-10, 10), math.random(-10, 10))
    asteroid.direction:Normalise()
    asteroid.rotation = math.random(-10, 10)
    asteroid.speed = 100

    asteroid.size = 1
    asteroid.offset = asteroid.image:getWidth() / 2

    asteroid.collisionRadius = 50

    asteroid.debugColour = { 0, 0, 0, 0 }

    table.insert(asteroids, asteroid)
    return asteroid
end

--[[
    Updates the position of an Asteroid object.
]]
function Asteroid:Update(dt)
    self.position.x = self.position.x + self.direction.x * self.speed * dt
    self.position.y = self.position.y + self.direction.y * self.speed * dt

    -- Wrap to the other side of the screen if the asteroid is past the screen edge
    if self.position.x < -50 then
        self.position.x = WINDOW_W
    elseif self.position.x > WINDOW_W + 50 then
        self.position.x = -50
    end
    if self.position.y < -50 then
        self.position.y = WINDOW_H
    elseif self.position.y > WINDOW_H + 50 then
        self.position.y = -50
    end
end

--[[
    Renders an Asteroid object to the screen. If debugging is enabled,
    render a circle around the asteroid that represents the collision radius.
]]
function Asteroid:Render(debug)
    love.graphics.draw(self.image, self.position.x, self.position.y,
                       self.rotation, self.size, self.size,
                       self.offset, self.offset)

    if not debug then
        return
    end

    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.debugColour)
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
    love.graphics.setColor(r, g, b, a)
end

--[[
    Updates the position of all existing asteroids.
]]
function UpdateAllAsteroids(dt)
    if asteroids ~= nil then
        for i = #asteroids, 1, -1 do
            asteroids[i]:Update(dt)
        end
    end
end

--[[
    Renders all existing asteroids.
]]
function RenderAllAsteroids(debug)
    if asteroids ~= nil then
        for i = #asteroids, 1, -1 do
            asteroids[i]:Render(debug)
        end
    end
end

--[[
    Returns a reference to the asteroids table.
]]
function GetAsteroids()
    return asteroids
end

--[[
    Deletes an asteroid when it is hit by a projectile. Depending on the
    size of the asteroid, two smaller asteroids may be created at its
    location and sent in a random direction, opposite each other.
]]
function AsteroidHit(i)
    -- Get a reference to the asteroid that was hit
    h = asteroids[i]

    -- Check whether we have to create two new smaller asteroids
    if h.size > 0.5 then
        -- Create two asteroids at the position of the hit asteroid
        a = Asteroid:New(h.position.x, h.position.y)
        b = Asteroid:New(h.position.x, h.position.y)

        -- Smaller asteroids are worth more points
        a.scoreValue = h.scoreValue + 10
        b.scoreValue = h.scoreValue + 10

        -- Reduce their size and collision radii
        a.size = h.size - 0.2
        b.size = h.size - 0.2
        a.collisionRadius = h.collisionRadius - 10
        b.collisionRadius = h.collisionRadius - 10

        -- Create a random direction vector and normalise it
        dir = Vector2:New(math.random(-10, 10), math.random(-10, 10))
        dir:Normalise()

        -- Send the two asteroids away at a straight angle
        a.direction = Vector2:New( dir.x,  dir.y)
        b.direction = Vector2:New(-dir.x, -dir.y)

        -- Increase their speed
        a.speed = h.speed + 30
        b.speed = h.speed + 30
    end

    -- Remove the asteroid that was hit from the asteroids table
    table.remove(asteroids, i)
end


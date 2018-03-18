--[[
    File: Projectile.lua
    Author: Sam Triest

    Defines the blueprint for projectiles, and their functionality.
]]

Projectile =
{
    position,
    direction,
    speed,
    size
}

--[[
    Contains all projectiles.
]]
local projectiles = {}

--[[
    Creates a new Projectile object and adds it to the projectiles table.
]]
function Projectile:New(position, direction)
    newProjectile = {}
    setmetatable(newProjectile, self)
    self.__index = self

    newProjectile.position = position
    newProjectile.direction = direction
    newProjectile.speed = 800
    newProjectile.size = 1

    table.insert(projectiles, newProjectile)
end

--[[
    Updates the position of a Projectile object.
]]
function Projectile:Update(dt)
    self.position.x = self.position.x + self.direction.x * self.speed * dt
    self.position.y = self.position.y + self.direction.y * self.speed * dt
end

--[[
    Renders a Projectile object to the screen.
]]
function Projectile:Render()
    love.graphics.rectangle("fill",
                            self.position.x, self.position.y,
                            self.size, self.size)
end


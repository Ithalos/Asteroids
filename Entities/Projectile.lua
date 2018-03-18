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


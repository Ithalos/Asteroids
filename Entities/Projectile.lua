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

--[[
    Returns true if the projectile is past the screen edges, else false.
]]
function Projectile:OutOfBounds()
    if self.position.x < 0 or self.position.x > WINDOW_W or
       self.position.y < 0 or self.position.y > WINDOW_H then
        return true
    else
        return false
    end
end

--[[
    Updates the position of all existing projectiles.
    Deletes projectiles that are no longer on screen.
]]
function UpdateAllProjectiles(dt)
    if projectiles ~= nil then
        -- Iterate backwards to prevent issues when removing indices
        for i = #projectiles, 1, -1 do
            projectiles[i]:Update(dt)

            -- Remove current projectile if it's past the screen edges
            if projectiles[i]:OutOfBounds() then
                table.remove(projectiles, i)
            end
        end
    end
end

--[[
    Renders all existing projectiles.
]]
function RenderAllProjectiles()
    if projectiles ~= nil then
        for i = 1, #projectiles do
            projectiles[i]:Render()
        end
    end
end

--[[
    Deletes a projectile object.
]]
function Projectile:Delete(i)
    table.remove(projectiles, i)
end


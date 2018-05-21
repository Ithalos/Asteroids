--[[
    File: Collision.lua
    Author: Sam Triest

    Handles collisions between asteroids, projectiles and the player.
]]

local red   = { 255,   0,   0, 255 }
local green = {   0, 255,   0, 255 }

--[[
    Iterates over the current asteroids and projectiles in the game, and checks
    whether any projectiles are colliding with any asteroids.
]]
function DetectCollisions()
    p = GetProjectiles()
    a = GetAsteroids()

    -- Return if we have no elements to iterate over
    if #a < 1 and #p < 1 then
        return
    end

    -- Iterate over every asteroid
    for i = #a, 1, -1 do
        -- Iterate over every projectile
        for j = #p, 1, -1 do
            -- Ensure the element exists
            if a[i] ~= nil and p[j] ~= nil then
                -- Check the distance between the current asteroid and projectile
                if InRange(a[i].position, p[j].position, a[i].collisionRadius) then
                    player:IncreaseScore(a[i].size)
                    DeleteProjectileByIndex(j)
                    AsteroidHit(i)
                end
            end
        end
    end
end

--[[
    Checks whether two points (2D Vectors) are within a specified distance
    of each other. Calculate the Euclidean distance between them, and return
    true if that distance is less than the distance specified, else false.
]]
function InRange(p1, p2, distance)
    deltaX = math.abs(p1.x - p2.x)
    deltaY = math.abs(p1.y - p2.y)
    deltaVec = Vector2:New(deltaX, deltaY)

    return deltaVec:Length() < distance
end


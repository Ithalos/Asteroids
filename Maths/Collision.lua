--[[
    File: Collision.lua
    Author: Sam Triest

    Handles collisions between asteroids, projectiles and the player.
]]

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
                if InRange(a[i], p[j], a[i].collisionRadius) then
                    AsteroidHit(i)
                    DeleteProjectileByIndex(j)
                end
            end
        end
    end
end

--[[
    Checks whether two points are within a specified distance of each other.
]]
function InRange(p1, p2, distance)
    -- This is not entirely accurate when using circles, but works for now
    return math.abs(p1.position.x - p2.position.x) < distance and
           math.abs(p1.position.y - p2.position.y) < distance
end


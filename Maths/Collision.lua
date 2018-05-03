--[[
    File: Collision.lua
    Author: Sam Triest

    Handles collisions between asteroids, projectiles and the player.
]]

--[[
    Checks whether two points are within a specified distance of each other.
]]
function InRange(p1, p2, distance)
    -- This is not entirely accurate when using circles, but works for now
    return math.abs(p1.position.x - p2.position.x) < distance and
           math.abs(p1.position.y - p2.position.y) < distance
end


--[[
    File: Vector2.lua
    Author: Sam Triest

    Allows creation and manipulation of 2D Vectors.
]]

Vector2 =
{
    x, y
}

--[[
    Creates and returns a new Vector2, after assigning it values for x & y.
]]
function Vector2:New(x, y)
    newVector2 = {}
    setmetatable(newVector2, self)
    self.__index = self
    newVector2.x = x
    newVector2.y = y
    return newVector2
end


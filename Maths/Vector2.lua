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

--[[
    Returns the length or magnitude of a Vector2.
]]
function Vector2:Length()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

--[[
    Normalises a Vector2 and returns the result as a new Vector2.
    A normalised Vector2 always has a length of 1.
]]
function Vector2:Normalise()
    normalised = Vector2:New(self.x / self:Length(), self.y / self:Length())
    return normalised
end


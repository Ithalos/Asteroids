--[[
    File: Scene.lua
    Author: Sam Triest

    Handles the creation and usage of scenes.
]]

Scene = {}

--[[
    Creates a Scene object that will be used to inherit functions from.
]]
function Scene:New()
    scene = {}
    setmetatable(scene, self)
    self.__index = self

    return scene
end


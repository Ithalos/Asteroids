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

--[[
    Used to perform any setup the scene might require.
]]
function Scene:Init()
end

--[[
    Gets called in love.draw() every frame, renders the scene.
]]
function Scene:Render()
end

--[[
    Gets called in love.update(dt) every frame, updates the scene.
]]
function Scene:Update(dt)
end

--[[
    Sends keypresses to the current scene.
]]
function Scene:KeyPressed(key)
end

--[[
    Used to perform any cleanup the scene might require.
]]
function Scene:Stop()
end

--[[
    Stop the current scene (if there is one), then load and start a scene
    by its index in the Scenes table.
]]
function LoadScene(i)
    if i < 1 or i > #Scenes then
        error("Cannot load scene: index out of bounds!")
    end

    if scene ~= nil then
        scene:Stop()
    end

    scene = Scenes[i]
    scene:Init()
end


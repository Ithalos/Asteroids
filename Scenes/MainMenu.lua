--[[
    File: MainMenu.lua
    Author: Sam Triest

    The scene file for the main menu.
]]

MainMenu = Scene:New()

local options =
{
    "Start",
    "Quit"
}
local selected

--[[
    MainMenu setup.
]]
function MainMenu:Init()
    -- Spawn some asteroids to create a dynamic background
    for i = 0, 5 do
        Asteroid:New()
    end
end

--[[
    Update the scene every frame.
]]
function MainMenu:Update(dt)
    UpdateAllAsteroids(dt)
end

--[[
    Clean up MainMenu resources.
]]
function MainMenu:Stop()
    DeleteAllAsteroids()
end


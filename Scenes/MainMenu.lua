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
    -- Make "Start" the default selected option when the menu loads
    selected = options[1]

    -- Spawn some asteroids to create a dynamic background
    for i = 0, 5 do
        Asteroid:New()
    end
end

--[[
    Render the scene every frame.
]]
function MainMenu:Render()
    RenderAllAsteroids()
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


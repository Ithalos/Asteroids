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
    selected = 1

    -- Spawn some asteroids to create a dynamic background
    for i = 0, 5 do
        Asteroid:New()
    end
end

--[[
    Render the scene every frame.
]]
function MainMenu:Render()
    love.graphics.printf("Welcome to Asteroids!", 0, WINDOW_H / 4, WINDOW_W, "center")

    r, g, b, a = love.graphics.getColor()
    -- Iterate over the menu options and highlight the selected option in red
    for i = 1, #options do
        if options[i] == options[selected] then
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.printf(options[i], 0, (WINDOW_H * 0.75) + (i * 50), WINDOW_W, "center")
        -- Reset the colour
        love.graphics.setColor(r, g, b, a)
    end

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


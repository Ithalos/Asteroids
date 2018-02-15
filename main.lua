--[[
    File: main.lua
    Author: Sam Triest

    The main program.
]]

-- Game window dimensions (4:3 Aspect Ratio)
WINDOW_W = 1200
WINDOW_H = 900

--[[
    Initial program setup.
]]
function love.load()
    -- Set the display mode & properties of the game window
    love.window.setMode(
        WINDOW_W,
        WINDOW_H,
        {
            fullscreen = false,
            vsync = true,
            resizable = false
        })

    -- Set window title
    love.window.setTitle("Asteroids")

    -- Set background colour
    love.graphics.setBackgroundColor(0, 0, 0)

    -- Set foreground colour
    love.graphics.setColor(255, 255, 255, 255)
end


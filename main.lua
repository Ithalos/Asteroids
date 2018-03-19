--[[
    File: main.lua
    Author: Sam Triest

    The main program.
]]

-- Dependencies
require "Maths/Vector2"
require "Entities/Player"
require "Entities/Projectile"

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
            vsync = false,
            resizable = false
        })

    -- Set window title
    love.window.setTitle("Asteroids")

    -- Set background colour
    love.graphics.setBackgroundColor(0, 0, 0)

    -- Set foreground colour
    love.graphics.setColor(255, 255, 255, 255)

    -- Initialise the player's ship in the middle of the screen
    player = Player:New(Vector2:New(WINDOW_W / 2, WINDOW_H / 2))

    -- Set up the ship's collision radius
    player:CircleCollisionSetup(25)
end

--[[
    Draws to the screen every frame.
]]
function love.draw()
    player:Render()
    player:RenderDebug()
end

--[[
    Updates the state of the game every frame.
]]
function love.update(dt)
    player:Move(dt)
end


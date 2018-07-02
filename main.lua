--[[
    File: main.lua
    Author: Sam Triest

    The main program.
]]

-- Game window dimensions (4:3 Aspect Ratio)
WINDOW_W = 1200
WINDOW_H = 900

-- Dependencies
require "Maths/Vector2"
require "Maths/Collision"
require "Entities/Player"
require "Entities/Projectile"
require "Entities/Asteroid"
require "Scenes/Scene"

require "Scenes/MainMenu"
require "Scenes/Game"
require "Scenes/GameOver"

--[[
    Initial program setup.
]]
function love.load()
    -- Seed the pseudorandom number generator with the current time
    math.randomseed(os.time())

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

    -- The game will render additional debugging information if set to true
    debug = false

    -- Set a dark grey background colour
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    -- Set a white foreground colour
    love.graphics.setColor(1, 1, 1, 1)

    -- Set up a font to display the player's score and lives remaining
    font = love.graphics.newFont(20)
    -- Smaller font to display the controls
    keysFont = love.graphics.newFont(12)
    love.graphics.setFont(font)

    -- Initialise scenes
    Scenes =
    {
        MainMenu,
        Game,
        GameOver
    }
    -- Load the main menu scene
    LoadScene(1)
end

--[[
    Draws to the screen every frame.
]]
function love.draw()
    scene:Render()
end

--[[
    Updates the state of the game every frame.
]]
function love.update(dt)
    scene:Update(dt)
end

--[[
    Triggers when a key is pressed.
]]
function love.keypressed(key)
    scene:KeyPressed(key)

    -- Exit the game
    if key == "escape" then
        love.event.quit()
    end

    if key == "f1" then
        debug = not debug
    end
end


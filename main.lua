--[[
    File: main.lua
    Author: Sam Triest

    The main program.
]]

-- Dependencies
require "Maths/Vector2"
require "Maths/Collision"
require "Entities/Player"
require "Entities/Projectile"
require "Entities/Asteroid"

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
    love.graphics.setBackgroundColor(25, 25, 25)

    -- Set foreground colour
    love.graphics.setColor(255, 255, 255, 255)

    -- Initialise the player's ship in the middle of the screen
    player = Player:New()

    -- Set up the ship's collision radius
    player:CircleCollisionSetup(25)

    -- Remember time since last shot
    timeSinceLastShot = 0

    -- Set up the cooldown between shots
    shotCooldown = 0.1

    -- Set up a font to display the player's score and lives remaining
    font = love.graphics.newFont(20)
end

--[[
    Draws to the screen every frame.
]]
function love.draw()
    -- Render the player to the screen
    player:Render()
    -- Render the player's score to the screen
    player:RenderScore(font, 100, 100)
    -- Render the player's debug information
    player:RenderDebug()

    -- Render all projectiles & asteroids to the screen
    RenderAllProjectiles()
    RenderAllAsteroids(true)
end

--[[
    Updates the state of the game every frame.
]]
function love.update(dt)
    -- Update the position of the player's ship
    player:Move(dt)

    -- Update the position of all projectiles & asteroids
    UpdateAllProjectiles(dt)
    UpdateAllAsteroids(dt)

    -- Detect collisions between asteroids & projectiles
    DetectCollisions()

    -- Allow the player to fire projectiles
    player:Shoot(dt)
end

--[[
    Triggers when a key is pressed.
]]
function love.keypressed(key)
    -- Exit the game
    if key == "escape" then
        love.event.quit()
    end

    -- Spawn an asteroid for debugging purposes
    if key == "return" then
        Asteroid:New(math.random(0, WINDOW_W), math.random(0, WINDOW_H))
    end
end


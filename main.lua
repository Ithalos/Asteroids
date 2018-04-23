--[[
    File: main.lua
    Author: Sam Triest

    The main program.
]]

-- Dependencies
require "Maths/Vector2"
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
    love.graphics.setBackgroundColor(0, 0, 0)

    -- Set foreground colour
    love.graphics.setColor(255, 255, 255, 255)

    -- Initialise the player's ship in the middle of the screen
    player = Player:New(Vector2:New(WINDOW_W / 2, WINDOW_H / 2))

    -- Set up the ship's collision radius
    player:CircleCollisionSetup(25)

    -- Remember time since last shot
    timeSinceLastShot = 0

    -- Set up the cooldown between shots
    shotCooldown = 0.1
end

--[[
    Draws to the screen every frame.
]]
function love.draw()
    -- Render the player to the screen
    player:Render()
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

    --[[
        Fire a projectile if the space key is down, and it has been
        at least 0.1 seconds since the last shot.
    ]]
    if love.keyboard.isDown("space") then
        if timeSinceLastShot > shotCooldown then
            timeSinceLastShot = 0
            player:Shoot()
        end
    end
    -- Update time since last shot
    timeSinceLastShot = timeSinceLastShot + dt
end

--[[
    Triggers when a key is pressed.
]]
function love.keypressed(key)
    -- Exit the game
    if key == "escape" then
        love.event.quit()
    end
end


--[[
    File: Game.lua
    Author: Sam Triest

    The scene file for the game.
]]

Game = Scene:New()

local respawnTime = 2
local timer
local wait

--[[
    Game setup.
]]
function Game:Init()
    self.player = Player:New()

    timer = respawnTime
    wait = false

    SpawnAsteroids(10)
end

--[[
    Render the scene every frame.
]]
function Game:Render()
    self.player:Render(debug)
    self.player:RenderScore(font, 100, 100)
    self.player:RenderLives(font, WINDOW_W - 200, 120)

    RenderAllProjectiles()
    RenderAllAsteroids(debug)
end

--[[
    Update the scene every frame.
]]
function Game:Update(dt)
    self.player:Update(dt)
    self.player:Shoot(dt)

    UpdateAllAsteroids(dt)
    UpdateAllProjectiles(dt)

    DetectProjectileCollisions(self.player)
    DetectPlayerCollision(self.player)

    --[[
        If there are no more asteroids, wait a few seconds (defined by respawnTime),
        then spawn a new wave.
    ]]
    if #GetAsteroids() < 1 then
        wait = true
    end
    if wait then
        timer = timer - dt
    end
    if timer <= 0 then
        timer = respawnTime
        wait = false
        SpawnAsteroids(10)
    end
end


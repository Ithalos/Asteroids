--[[
    File: Game.lua
    Author: Sam Triest

    The scene file for the game.
]]

Game = Scene:New()

--[[
    Game setup.
]]
function Game:Init()
    self.player = Player:New()

    -- Number of initial asteroids to spawn
    local asteroidCount = 10
    for i = 1, asteroidCount do
        -- Select a random location from the spawns table
        local spawn = spawns[math.random(1, #spawns)]
        Asteroid:New(spawn[1], spawn[2])
    end
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
end


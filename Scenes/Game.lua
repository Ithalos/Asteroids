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
end


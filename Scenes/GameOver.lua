--[[
    File: GameOver.lua
    Author: Sam Triest

    The scene file for the game over screen.
]]

GameOver = Scene:New()

local options =
{
    "Play again",
    "Quit"
}
local selected

--[[
    Scene setup.
]]
function GameOver:Init()
    -- Make "Play again" the default selected option when the scene loads
    selected = 1
end


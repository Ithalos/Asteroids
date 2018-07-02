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

--[[
    Render the scene every frame.
]]
function GameOver:Render()
    love.graphics.printf("Game over!", 0, WINDOW_H / 4, WINDOW_W, "center")
    love.graphics.printf("Score: " .. player.score, 0, WINDOW_H / 3, WINDOW_W, "center")

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

    -- Display the controls in a smaller font, in a red colour
    love.graphics.setFont(keysFont)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf("Movement:     Arrow Keys",    50, 730, WINDOW_W, "left")
    love.graphics.printf("Shoot:            Spacebar",  50, 760, WINDOW_W, "left")
    love.graphics.printf("Hyperspace:   Left Control",  50, 790, WINDOW_W, "left")
    love.graphics.setColor(r, g, b, a)
    love.graphics.setFont(font)

    RenderAllAsteroids()
end

--[[
    Update the scene every frame.
]]
function GameOver:Update(dt)
    UpdateAllAsteroids(dt)
end

--[[
    Clean up resources.
]]
function GameOver:Stop()
    DeleteAllAsteroids()
end

--[[
    Let the user navigate the menu using the keyboard.
]]
function GameOver:KeyPressed(key)
    if key == "down" then
        selected = selected + 1
    elseif key == "up" then
        selected = selected - 1
    end

    -- Clamp values
    if selected < 1 then
        selected = 1
    elseif selected > #options then
        selected = #options
    end

    if key == "return" then
        -- Selected: "Play again"
        if selected == 1 then
            LoadScene(2)
        -- Selected: "Quit"
        elseif selected == 2 then
            love.event.quit()
        end
    end
end


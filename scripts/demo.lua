demo = Class {}

local function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0.5, 0, 0.5, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

local function displayPressedKey()
    if (nil == lastPressedKey) then
        love.graphics.print('Press any key', 10, 25)
        return nil
    end
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0.5, 0, 0.5, 1)
    love.graphics.print('Pressed: ' .. lastPressedKey, 10, 25)
end

function demo:draw()
    -- main canvas bg color
    love.graphics.clear(1, 1, 1, 1)
    displayFPS()
    displayPressedKey()
end

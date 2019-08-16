-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
class = require 'packages/hump/class'

demo = class {}

function demo:displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0.5, 0, 0.5, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function demo:displayPressedKey()
    if (nil == lastPressedKey) then
        love.graphics.print('Press any key', 10, 25)
        return nil
    end
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0.5, 0, 0.5, 1)
    love.graphics.print('Pressed: ' .. lastPressedKey, 10, 25)
end

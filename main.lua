love.filesystem.setRequirePath('?.lua;scripts/?.lua;?/init.lua')

ResolutionHelper = require 'packages/push/push'
Class = require 'packages/hump/class'

require 'demo'
require 'setup'

GAME_ID = 'love2d-template'

function love.conf(t)
    setup:conf(t);
end

function love.load()
    setup:load();
end

function love.draw()
    -- outer canvas bg color
    love.graphics.clear(120 / 255, 120 / 255, 120 / 255, 1)
    ResolutionHelper:start()
    demo:draw()
    ResolutionHelper:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit(0)
    end
    lastPressedKey = key
end

function love.resize(w, h)
    ResolutionHelper:resize(w, h)
end

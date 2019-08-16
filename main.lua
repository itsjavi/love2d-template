GAME_ID = 'love2d-template'

sti = require 'packages.tiled.sti'
ResolutionHelper = require 'packages.push.push'
Class = require 'packages.hump.class'
Camera = require 'packages.hump.camera'

love.filesystem.setRequirePath('?.lua;scripts/?.lua;?/init.lua')

player = {
    pos = {
        x = 0,
        y = 0
    }
}

require 'demo'
require 'setup'

function love.conf(t)
    setup:conf(t);
end

function love.load()
    setup:load();

    -- Load map file
    map01 = sti("assets/tilemaps/newbark.lua")

    player.pos.x = WINDOW_WIDTH / 2;
    player.pos.y = WINDOW_HEIGHT / 2;

    camera = Camera(player.pos.x, player.pos.y)
end

function love.update(dt)
    map01:update(dt)

    -- 32 pixels per second
    local speed = 32 * dt

    -- Move player up
    if love.keyboard.isDown("w", "up") then
        player.pos.y = player.pos.y - speed
    end

    -- Move player down
    if love.keyboard.isDown("s", "down") then
        player.pos.y = player.pos.y + speed
    end

    -- Move player left
    if love.keyboard.isDown("a", "left") then
        player.pos.x = player.pos.x - speed
    end

    -- Move player right
    if love.keyboard.isDown("d", "right") then
        player.pos.x = player.pos.x + speed
    end

    local dx,dy = player.pos.x - camera.x, player.pos.y - camera.y
    camera:move(dx/2, dy/2)
end

local function onBeforeDraw()
    camera:attach()
    -- outer canvas bg color
    love.graphics.clear(120 / 255, 120 / 255, 120 / 255, 1)
    ResolutionHelper:start()
end

local function onDraw()
    ResolutionHelper:finish()
    camera:detach()
end

function love.draw()
    onBeforeDraw()

    -- Scale world
    local scale = 2
    local screen_width  = love.graphics.getWidth()  / scale
    local screen_height = love.graphics.getHeight() / scale

    -- Translate world so that player is always centred
    local tx = math.floor(player.pos.x - screen_width  / 2)
    local ty = math.floor(player.pos.y - screen_height / 2)

    -- Transform world
    love.graphics.scale(scale)
    love.graphics.translate(-tx, -ty)

    -- Draw world
    map01:draw()

    onDraw()
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

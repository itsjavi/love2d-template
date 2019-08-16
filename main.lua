love.filesystem.setRequirePath('?.lua;scripts/?.lua;?/init.lua')

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
push = require 'packages/push/push'

require 'demo'

GAME_ID = 'love2d-template'
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 320, 288 --virtual resolution
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

function love.conf(t)
    t.version = "11.2"
    t.identity = GAME_ID -- This flag determines the name of the save directory for your game.
end

function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle(GAME_ID)

    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('assets/fonts/8bit.ttf', 8)
    mediumFont = love.graphics.newFont('assets/fonts/8bit.ttf', 12)
    largeFont = love.graphics.newFont('assets/fonts/8bit.ttf', 16)

    love.graphics.setFont(smallFont)
    love.graphics.setColor(0.5, 0, 0.5, 1)

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.draw()
    -- outer canvas bg color
    love.graphics.clear(120 / 255, 120 / 255, 120 / 255, 1)
    push:start()

    -- main canvas bg color
    love.graphics.clear(1, 1, 1, 1)

    -- draw
    demo:displayFPS()
    demo:displayPressedKey()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit(0)
    end
    lastPressedKey = key
end

function love.resize(w, h)
    push:resize(w, h)
end

setup = Class {}

function setup:windowSize(windowScale)
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 320, 288 --virtual resolution
    DEVICE_WIDTH, DEVICE_HEIGHT = love.window.getDesktopDimensions()

    WINDOW_WIDTH = math.min(VIRTUAL_WIDTH * windowScale)
    WINDOW_HEIGHT = math.min(VIRTUAL_HEIGHT * windowScale)

    if (WINDOW_WIDTH > DEVICE_WIDTH or WINDOW_HEIGHT > DEVICE_HEIGHT) then
        WINDOW_WIDTH = DEVICE_WIDTH
        WINDOW_HEIGHT = DEVICE_HEIGHT
    end
end

function setup:conf(t)
    t.version = "11.2"
    t.identity = GAME_ID -- This flag determines the name of the save directory for your game.
end

function setup:load()
    setup:windowSize(1)

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
    ResolutionHelper:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        pixelperfect = true
    })
end

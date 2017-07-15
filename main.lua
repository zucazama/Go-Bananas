_G.width, _G.height, _G.flags = love.window.getMode()

function love.load()
    require "lib/unpack"
    require "whatIsVisible"
    require "gap"
    require "font"
    require "screen_opening"
    require "menu"
    require "map"
    require "enemy"
    require "sources"    


    menu:load()
    map.load()
    ca:new("GO BANANAS", _G.width/2, _G.height/4)

    -- Valores defalt
    love.graphics.setBackgroundColor(button.setColor("orange"))

    whatIsVisible.gap = true
    delay = 0.5
    -- whatIsVisible.menu = false
    -- whatIsVisible.openScreen = false
    buttonPressed = [[]]

end

function love.update(dt)
    -- ui.sound.background:setVolume(0.7)
    -- ui.sound.background:play()
    if whatIsVisible.gap then
        ca:update(dt)

        if whatIsVisible.openScreen then
            ui.sound.abertura:setVolume(0.2)
            ui.sound.abertura:play()
        end
    else

        menu:scene(dt)

        if whatIsVisible.menu then 
            ui.sound.background:setVolume(0.1)
            menu:update(dt) 
        else start.update(dt) end

    end
    
    _G.width, _G.height, _G.flags = love.window.getMode()


end


function love.draw()

    if whatIsVisible.menu then

        map.show()
    
        if whatIsVisible.openScreen then screen_start.show()
        elseif whatIsVisible.menu then menu:show() 

        else 
            start.show()  
        end

    end
    if whatIsVisible.gap then
        ca:show()
    end

end

function love.mousepressed(x, y, key)
        ui.sound.click:play()

        if whatIsVisible.menu then menu:mousepressed(x, y, key) else --[[table.insert(cliques, start.new(x, y))]] end
end

function love.mousemoved(x, y, dx, dy, istouch)
end

function love.keypressed(key, scancode, isrepeat)
    buttonPressed = key

    if key and whatIsVisible.openScreen and not whatIsVisible.menuButtons then
        whatIsVisible.menu = true; 
        whatIsVisible.userBar = true
        whatIsVisible.menuButtons = true;
        whatIsVisible.openScreen = false;
        whatIsVisible.gap = false

    end

    if whatIsVisible.start then map.keypressed(key, scancode, isrepeat); menu:keypressed(key, scancode, isrepeat) end
end
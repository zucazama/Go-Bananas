_G.width, _G.height, _G.flags = love.window.getMode()

function love.load()
    -- body
    require "whatIsVisible"
    require "gap"
    require "font"
    require "screen_opening"
    require "menu"
    require "map"
    require "enemy"
    


    sonds = {
        ['abertura'] = love.audio.newSource('assets/audio/background/Zoom.mp3'),
        ['background'] = love.audio.newSource('assets/audio/background/You_Like_It.mp3'),
        ['click'] = love.audio.newSource('assets/audio/click.mp3', 'static'),
        love.audio.newSource('assets/audio/powerup.mp3'),
        love.audio.newSource('assets/audio/background/Hackerland.mp3'),
        love.audio.newSource('assets/audio/background/Hip Hop Rap Instrumental (Crying Over You) - Chris Morrow 4 (Free Copyright Music).mp3')
    }

    menu:load()
    map.load()
    ca:new("GO BANANAS", 300, 200)
    -- text1:new("Um jogo de quiui studio", 100, 100)

    -- font = love.graphics.newFont('assets/fonts/Arkhip_font.ttf', 30)

    -- love.graphics.setBackgroundColor(love.math.random(255), love.math.random(255), love.math.random(255))


    -- Valores defalt
    love.graphics.setBackgroundColor(button.setColor("orange"))

    whatIsVisible.gap = true
    delay = 0.5
    -- whatIsVisible.menu = false
    -- whatIsVisible.openScreen = false
    buttonPressed = [[]]

end

function love.update(dt)
    -- sonds.background:setVolume(0.7)
    -- sonds.background:play()
    if whatIsVisible.gap then
        ca:update(dt)
        -- sonds.abertura:setVolume(0.2)
        -- sonds.abertura:play()

    else

        menu:scene(dt)

        -- background.new(dt)
        -- background.update(dt)

        if whatIsVisible.menu then 
            sonds.background:setVolume(0.2)
            menu:update(dt) 
        else start.update(dt) end

    end
    
    _G.width, _G.height, _G.flags = love.window.getMode()
    -- love.audio.play(audio[2])

--    if love.mouse.isDown(1) then
--         font = love.graphics.setNewFont(40)
--         love.graphics.setBackgroundColor(250, 200, 50)
--     else
--         love.graphics.setBackgroundColor(250, 150, 100)
--         --love.graphics.setDefaultFilter()
--         font = love.graphics.setNewFont(30)
--     end


end


function love.draw()

    if whatIsVisible.gap then
    
    -- text1:show()
    ca:show()
    else
    -- love.graphics.print(tostring(buttonPressed), 10, 10)
    -- background.show()
    map.show()
    -- button:show()
    
    if whatIsVisible.openScreen then screen_start.show()
    elseif whatIsVisible.menu then menu:show() 

    else 
        start.show()
        -- cliques[1]()
  
    end

    if whatIsVisible.userBar then userBarBotton:show() end
end
    -- love.graphics.setColor(255, 255, 255, 50)
    -- love.graphics.rectangle('fill', math.abs(outroTexto:getWidth() - 100), math.abs(outroTexto:getHeight() - 100), (outroTexto:getWidth() + 15), (outroTexto:getHeight() + 10))
    

    -- love.graphics.setColor(255, 255, 255)
    -- love.graphics.draw(testTexto, math.abs(outroTexto:getWidth() - 100), math.abs(outroTexto:getHeight() - 200))

    -- love.graphics.draw(outroTexto, math.abs(outroTexto:getWidth() - 100), math.abs(outroTexto:getHeight() - 100))

    -- love.graphics.draw(self.title, self.position.x, self.position.y)

end

function love.mousepressed(x, y, key)
        -- love.graphics.setFont(font, 50)
        sonds.click:play()

        if whatIsVisible.menu then menu:mousepressed(x, y, key) else --[[table.insert(cliques, start.new(x, y))]] end
end

function love.mousemoved(x, y, dx, dy, istouch)
    -- button:houver(x, y)
    -- background.mousemoved(x, y, dx, dy)
end

function love.keypressed(key, scancode, isrepeat)
    buttonPressed = key

    if key and whatIsVisible.openScreen and not whatIsVisible.menu then
        whatIsVisible.menu = true; 
        whatIsVisible.menuButtons = true;
        whatIsVisible.openScreen = false;

    end

    if whatIsVisible.start then map.keypressed(key, scancode, isrepeat); menu:keypressed(key, scancode, isrepeat) end
    -- if key == 'escape' then whatIsVisible.menu = true end

    if key == 'space' and not whatIsVisible.menu then whatIsVisible.menu = false; whatIsVisible.userBar = false end
    -- if key == 'space' and isrepeat then whatIsVisible.menu = false end
end
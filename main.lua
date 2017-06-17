_G.width, _G.height, _G.flags = love.window.getMode()

function love.load()
    -- body
    require "font"
    require "screen_opening"
    require "menu"


    sonds = {
        ['abertura'] = love.audio.newSource('assets/audio/background/Foundation.mp3'),
        ['background'] = love.audio.newSource('assets/audio/background/You_Like_It.mp3'),
        ['click'] = love.audio.newSource('assets/audio/click.mp3', 'static'),
        love.audio.newSource('assets/audio/powerup.mp3'),
        love.audio.newSource('assets/audio/background/Hackerland.mp3'),
        love.audio.newSource('assets/audio/background/Hip Hop Rap Instrumental (Crying Over You) - Chris Morrow 4 (Free Copyright Music).mp3')
    }

    menu:load()

    -- font = love.graphics.newFont('assets/fonts/Arkhip_font.ttf', 30)

    love.graphics.setBackgroundColor(love.math.random(255), love.math.random(255), love.math.random(255))


    -- Valores defalt
    menuAppear = false
    screen_openingAppear = true
end

function love.update(dt)
    sonds.background:setVolume(0.7)
    sonds.background:play()

    menu:scene(dt)

    background.new(dt)
    background.update(dt)

    if menuAppear then 
        sonds.background:setVolume(0.2)
        menu:update(dt) 
    else start.update(dt) end
    
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

    love.graphics.print(tostring(#buttonsOnClickEx), 10, 10)
    background.show()
    -- button:show()
    if screen_openingAppear then screen_start.show()

    elseif menuAppear then menu:show() 

    else 
        start.show()
        -- cliques[1]()
        
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

        if menuAppear then menu:mousepressed(x, y, key) else --[[table.insert(cliques, start.new(x, y))]] end
end

function love.mousemoved(x, y, dx, dy, istouch)
    -- button:houver(x, y)
end

function love.keypressed(key, scancode, isrepeat)
    if key and screen_openingAppear and not menuAppear then
        menuAppear = true; 
        screen_openingAppear = false

    end
    if key == 'escape' then menuAppear = true end

    if key == 'space'then love.timer.sleep(5) end
    -- if key == 'space' and isrepeat then menuAppear = false end
end
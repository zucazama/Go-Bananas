
require "buttons"
require "winOrLose"
require "scoreGame"

-- Variáveis Globais
menu = {}



function menu:load()
    
    buttons:new('INÍCIO', 'left', function() whatIsVisible.menuButtons = false; whatIsVisible.start = true; whatIsVisible.score = true; --[[steve.load()]] end, 'orange', ui.image.play, false)
    buttons:new("RECOMEÇAR", "left", function() restart() end, "blue", ui.image.refresh, false)
    buttons:new('SAIR', 'left', 
        function() 
            whatIsVisible.menu = false
            love.event.quit()       
        end, 'red', ui.image.stop, false)
    -- buttons:new('Opções', 'left', function() menu.appear(true, 0.1) end, 'roxo', ui.image.stop, true)
    -- buttons:new('Personalizar', 'left', function() menu.appear(true, 0.1) end, "green", nil, true)
    -- button:new('Controles', 'left', function() return true end)

    winOrLoseButtons:newButton("RECOMEÇAR", ui.image.refresh, function() restart(); whatIsVisible.winOrLose = false; whatIsVisible.score = true; whatIsVisible.userBar = true; end, "blue", 2)
    winOrLoseButtons:newButton("SAIR", ui.image.stop, function() whatIsVisible.menu = false;  love.event.quit() end, "red", 2)

    userBarBotton:new(nil, ui.image.monkey, 0, 0, nil, function() return end)
    userBarBotton:new("STEVE", nil, 0, 0, "white", function() return end)
    userBarBotton:new(nil, ui.image.speaker, 0, 0, nil, 
        function() 
            if ui.sound.abertura:isPlaying() then
                ui.sound.abertura:pause()
                return
            end
            ui.sound.abertura:play() 
        end
    )
    userBarBotton:new(nil, ui.image.pause, 0, 0, nil, function() whatIsVisible.menuButtons = true; whatIsVisible.start = false; whatIsVisible.score = false end)
    

end

function menu:update(dt)

    if whatIsVisible.menuButtons then
        button:houver(love.mouse.getPosition())
        buttons:update(dt)
    end

    if whatIsVisible.start then 
        map.update(dt) 
    end

    if whatIsVisible.userBar then
        userBarBotton:houver(love.mouse.getPosition())
    end

    if whatIsVisible.winOrLose then
        winOrLoseButtons:buttonHouver(love.mouse.getPosition())
    end


end

function menu:mousepressed(x, y, key)
    if whatIsVisible.userBar then
        userBarBotton:onClick(x, y)
    end
    
    if whatIsVisible.menuButtons then button:onClick(x, y, key)
    elseif not whatIsVisible.winOrLose then map.mousepressed(x, y, key); end
    
    if whatIsVisible.winOrLose then winOrLoseButtons:onClick(x, y, key) end
    -- if whatIsVisible.start then weapons.new(choose or "axe", x, y) end
end

function menu:scene(dt)
end

function menu:keypressed(key)
end

function menu:show()
    -- A ordem Importa!
    life.show()

    
    if whatIsVisible.userBar then
        userBarBotton:show()
    end
    
    if whatIsVisible.menuButtons then 
        buttons:show()        
    end

    if whatIsVisible.start then end
    if whatIsVisible.score then score.show() end

    if whatIsVisible.winOrLose then
        winOrLose.show(chooseFrases)
        winOrLoseButtons:showButtons()
    end
    
end
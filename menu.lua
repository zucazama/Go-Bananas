
require "buttons"
require "background_menu"
require "start"
require "weapons"
require "weaponsScreen"

-- Variáveis Globais
menu = {}



function menu:load()
    

    buttons:new('Início', 'left', function() whatIsVisible.menuButtons = false; whatIsVisible.start = true end, 'orange', ui.play, false)
    buttons:new('Opções', 'left', function() menu.appear(true, 0.1) end, 'roxo', ui.stop, true)
    buttons:new('Personalizar', 'left', function() menu.appear(true, 0.1) end, "green", nil, true)
    buttons:new("Restart", "left", function() map.load(); enemys:destroy() end, "blue", love.graphics.newImage("assets/png/ui/png/replay.png"), false)
    -- button:new('Controles', 'left', function() return true end)
    buttons:new('Sair', 'left', 
        function() 
            whatIsVisible.menu = false
            
            -- love.timer.sleep(1)
            love.event.quit() 

        end, 'red', nil, false)

    -- background.load()

    userBarBotton:new(nil, "001-man", 0, 0, nil, function() return end)
    userBarBotton:new("STEVE", nil, 0, 0, "white", function() return end)
    userBarBotton:new(nil, "speaker-1", 0, 0, nil, function() sonds.abertura:play() end)
    userBarBotton:new("PAUSE", nil, 0, 0, "white", function() whatIsVisible.menuButtons = true; whatIsVisible.start = false end)
    

     weaponsScreen.new(love.graphics.newImage("axe.png"), "1", true)
     weaponsScreen.new(love.graphics.newImage("axe.png"), "2", false)
    --  weaponsScreen.new(love.graphics.newImage("axe.png"), "01", "AXE")
    -- userBarBotton:new("Clique em configurações", "001-mouse")
    -- userBarBotton:new("Buscar", "locked")
end

function menu:update(dt)

    userBarBotton:houver(love.mouse.getPosition())
    
    if whatIsVisible.menuButtons then
        button:houver(love.mouse.getPosition())
        buttons:update(dt)
    end

    if whatIsVisible.start then 
        map.update(dt) 
    end


end

function menu:mousepressed(x, y, key)
    userBarBotton:onClick(x, y)
    
    if whatIsVisible.menuButtons then button:onClick(x, y, key) end
    if whatIsVisible.start then weapons.new(choose or "axe", x, y) end
end

function menu:scene(dt)
    -- love.audio.play(audio[2])
    -- sonds[4]:setVolume(0.9)
    -- sonds[4]:play()


end

function menu:keypressed(key)
    if key == "1" then 
        choose = "axe" 
        weaponsScreen_List[1].select = true
        weaponsScreen_List[2].select = false
        
    elseif key == "2" then 
        choose = "hammer"
        weaponsScreen_List[2].select = true
        weaponsScreen_List[1].select = false
    end
end

function menu:show()
    -- A ordem Importa!
    -- love.graphics.print(tostring(_G.width), 10, 10)
    for index, value in pairs(buttonsOnClickEx) do
        -- Exibi o effeito quando um botão é clicado
        -- value()
        
        -- if value() == false then table.remove(buttonsOnClickEx, index) end
    end
    
    userBarBotton:show()
    
    if whatIsVisible.menuButtons then 
        buttons:show()
    else
        -- userBarBotton:new(nil, "speaker-1", 0, 0, nil, function() sonds.abertura:play() end) 
        
    end

    if whatIsVisible.start then
        weaponsScreen.show()
    end
    
    weapons.show()
    life.show()
end

function menu.appear(boolean, dl)
    if boolean then 
        if delay == 0 then 
            menuAppear = false
        end
    end
end

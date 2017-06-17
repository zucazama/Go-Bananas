
require "buttons"
require "background_menu"
require "start"

-- Variáveis Globais
menu = {}



function menu:load()
    

    button:new('Início', 'left', function() menu.appear(true, 0.1) end, 'defalt')
    button:new('Opções', 'left', function() menu.appear(true, 0.1) end, 'defalt')
    button:new('Sobre', 'left', function() menu.appear(true, 0.1) end)
    -- button:new('Conquistas', 'center', function() return true end)
    button:new('Sair', 'left', 
        function() 
            menuAppear = false
            
            love.timer.sleep(1)
            love.event.quit() 

        end)

    -- background.load()
end

function menu:update(dt)

    button:houver(love.mouse.getPosition())
    button:update(dt)



end

function menu:mousepressed(x, y, key)
    button:onClick(x, y, key)
end

function menu:scene(dt)
    -- love.audio.play(audio[2])
    -- sonds[4]:setVolume(0.9)
    -- sonds[4]:play()


end

function menu:show()
    -- A ordem Importa!
    -- love.graphics.print(tostring(_G.width), 10, 10)
    for index, value in pairs(buttonsOnClickEx) do
        -- Exibi o effeito quando um botão é clicado
        value()
        
        if value() == false then table.remove(buttonsOnClickEx, index) end
    end

    button:show()
end

function menu.appear(boolean, dl)
    if boolean then 
        if delay == 0 then 
            menuAppear = false
        end
    end
end

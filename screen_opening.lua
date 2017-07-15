screen_start = {}


screen_start.title = love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Pressione qualquer tecla para começar")

local r, g, b = 255, 255, 255
local alpha, alphaBoolean = 0, true



function screen_start.show()
    -- love.graphics.setColor(255, 255, 255, 100)
    -- love.graphics.draw(screen_start.title, _G.width/2 - (screen_start.title:getWidth()/2) + 2, _G.height/2 - (screen_start.title:getHeight()/2) + 2)
    -- love.graphics.rectangle("fill", 0, 0, width, height)

    love.graphics.setColor(r, g, b, alpha)
    love.graphics.draw(screen_start.title, _G.width/2 - (screen_start.title:getWidth()/2), _G.height/2 - (screen_start.title:getHeight()/2))

    love.graphics.setColor(0, 0, 0, alpha >= 20 and 20 or alpha)
    love.graphics.draw(screen_start.title, _G.width/2 - (screen_start.title:getWidth()/2) + 2, _G.height/2 - (screen_start.title:getHeight()/2) + 2)


    if alpha >= 0 and alpha < 255 and alphaBoolean then 
        alpha = alpha + 1    
    else 
        alpha = alpha - 1

        alphaBoolean = alpha == 0 and true or false
    end
end
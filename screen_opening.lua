screen_start = {}


screen_start.title = love.graphics.newText(font.mullerNarrow.light.size['30'], "Pressione qualquer tecla para começar")

r, g, b = 255, 255, 255
alpha, alphaBoolean = 0, true



function screen_start.show()

    love.graphics.setColor(r, g, b, alpha)
    love.graphics.draw(screen_start.title, _G.width/2 - (screen_start.title:getWidth()/2), _G.height/2 - (screen_start.title:getHeight()/2))

    if alpha >= 0 and alpha < 255 and alphaBoolean then 
        alpha = alpha + 1    
    else 
        alpha = alpha - 1

        alphaBoolean = alpha == 0 and true or false
    end
end
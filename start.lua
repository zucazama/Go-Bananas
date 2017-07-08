start = {}

cliques = {}

local explosion = love.graphics.newImage('assets/png/sprite/explosion.png')

local imagens = {}

for i = 0, 4 do
    for j = 0, 4 do
       table.insert(imagens, love.graphics.newQuad(j * 320, i * 232, 320, 232, explosion:getDimensions()))
    end
end


function start.update(dt)
    -- for index, value in pairs(cliques) do
    --     if value() == false then table.remove(cliques, index) end
    -- end
end

function start.new(dt, x, y)
    local delay = 0.1
    
    local i = 0
    local sw, sh = imagens[1]:getTextureDimensions()

    return function ()

        if delay <= 0 then 

        if i <= #imagens then
            i = i + 1 
        else    
            return false
        end

            delay = 0.1
        end

        love.graphics.draw(explosion, imagens[i], x, y)

        delay = delay - 1e-2
    end
end


function start.show()
    for _, value in pairs(cliques) do
        if value() == false then table.remove(cliques, index) end
    end
end
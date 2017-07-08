background = {}
cenas = {}

-- function background.load()
local imagens = {
    {
        -- Fruits
        love.graphics.newImage('assets/png/meat.png'),
        love.graphics.newImage('assets/png/orange.png'),
        love.graphics.newImage('assets/png/tomato.png'),
        love.graphics.newImage('assets/png/watermelon.png'),
        love.graphics.newImage('assets/png/apple.png'),
        love.graphics.newImage('assets/png/carrot.png'),
        love.graphics.newImage('assets/png/groceries.png'),
    },
    {
        -- Donuts
    },

}

for i = 1, 17 do
    table.insert(imagens[2], love.graphics.newImage("assets/png/donuts/png/" .. i .. ".png") or nil)
end
    delay = 0.2

    
    love.math.setRandomSeed(os.time() * os.clock() * love.math.random())
    categoriaImagem = love.math.random(#imagens)
    
-- end


function background.new(dt)
    -- love.audio.play(audio[2])
    -- sonds[4]:setVolume(0.9)
    -- sonds[4]:play()

    love.math.setRandomSeed(os.time() * os.clock())

    if delay <= 0 then
        --math.randomseed(os.time())

        -- local dx = love.math.random(0, love.graphics.getWidth())
        -- local dy = math.random(0, love.graphics.getHeight())
        -- local imagemAleatoria = love.math.random(#imagens)
        -- local r = 
        local imagem = imagens[categoriaImagem][love.math.random(#imagens[categoriaImagem])]
        local y = 0 - imagem:getHeight()

        table.insert(cenas, 
            {
            ['imagem'] = imagem, 
            ['position'] = {
                x = love.math.random(_G.width), 
                ['y'] = y
            },
            ['rotation'] = math.rad(love.math.random(360))
            }
        )

        delay = 0.2
    end

end
    

function background.update(dt)
    for i, _ in pairs(cenas) do
        cenas[i].position.y = cenas[i].position.y + 1
        cenas[i].rotation = cenas[i].rotation + math.rad(1)
  
        if cenas[i].position.y > _G.height + cenas[i].imagem:getHeight() then
            table.remove(cenas, i)
        end
    end
    
    delay = delay - dt
end

function background.mousemoved(x, y, dx, dy)
    local moduloX = (x - dx) * 1e-3
    local moduloY = (y - dy) * 1e-3

    for i, _ in pairs(cenas) do
        cenas[i].position.x = cenas[i].position.x + moduloX
        cenas[i].position.y = cenas[i].position.y + moduloY
    end
end

function background.show()
    for i, _ in pairs(cenas) do 
            -- love.graphics.print(tostring(i), 10, 10)
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(cenas[i].imagem, cenas[i].position.x, cenas[i].position.y, cenas[i].rotation, 1, 1, cenas[i].imagem:getWidth()/2, cenas[i].imagem:getHeight()/2)
    end
end
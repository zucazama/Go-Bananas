enemy = {}
enemy.__index = enemy

enemys = setmetatable({}, enemy)
local cont = 1

local imagens = {
        -- Fruits
        love.graphics.newImage('assets/png/meat.png'),
        love.graphics.newImage('assets/png/orange.png'),
        love.graphics.newImage('assets/png/tomato.png'),
        love.graphics.newImage('assets/png/watermelon.png'),
        love.graphics.newImage('assets/png/apple.png'),
        love.graphics.newImage('assets/png/carrot.png'),
        love.graphics.newImage('assets/png/groceries.png'),
    }


function enemy.new()
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    indexImage = math.random(#imagens)

    body = love.physics.newBody(world, math.random(_G.width), -(imagens[indexImage]:getHeight()), "dynamic")
    shape = love.physics.newRectangleShape(imagens[indexImage]:getWidth(), imagens[indexImage]:getHeight())
    fixture = love.physics.newFixture(body, shape, 1)
    body:setGravityScale(0.3)
    fixture:setRestitution(0)

    body:setUserData(tostring(cont))
    fixture:setUserData("enemy")

    -- table.insert(enemys, 
    enemys[body:getUserData()] = {
        ['body'] = body, 
        ['shape'] = shape, 
        ['fixture'] = fixture, 
        ['image'] = indexImage,
        ['life'] = love.graphics.newText(font.mullerNarrow.light.size[15], "100"),
        ['life_number'] = 100,
        ['damage'] = -30,
        }
    --)
    cont = cont + 1
end

function enemy:show()
    for i, _ in pairs(self) do
        if not self[i].body:isDestroyed() then
            love.graphics.setColor(255, 255, 255, 255)
            -- love.graphics.polygon("line", self[i].body:getWorldPoints(self[i].shape:getPoints()))
            love.graphics.draw(imagens[self[i].image], self[i].body:getX() - (imagens[self[i].image]:getWidth()/2), self[i].body:getY() - imagens[self[i].image]:getHeight()/2)
        
            -- love.graphics.draw()
            love.graphics.setColor(0, 0, 0, 100)
            love.graphics.rectangle("fill", self[i].body:getX() + imagens[self[i].image]:getHeight()/2 + 20, self[i].body:getY() - imagens[self[i].image]:getHeight()/2, self[i].life:getWidth() + 10, self[i].life:getHeight() + 10)
        
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(self[i].life, self[i].body:getX() + imagens[self[i].image]:getHeight()/2 + 25, self[i].body:getY() - imagens[self[i].image]:getHeight()/2 )
        -- print(self[i].fixture:getUserData())
        end
    end
end

function enemy.collider(a, b)

    userData_ = {}

    if a:getUserData() == "enemy" then
        userData_.body_A = a:getBody():getUserData()
        userData_.body_B = b:getBody():getUserData()
    else
        userData_.body_A = b:getBody():getUserData()
        userData_.body_B = a:getBody():getUserData()
    end   

    life.lost(enemys[userData_.body_A].damage, a:getBody():getPosition())
    life.lost(objetos[userData_.body_B].damage, b:getBody():getPosition())

    
    if (enemys[userData_.body_A].life_number + objetos[userData_.body_B].damage) <= 0 then 
        enemys[userData_.body_A].body:destroy()
        -- enemys[userData_.body_A].fixture:destroy()
        enemys[userData_.body_A] = nil
    else
        objetos[userData_.body_B].life = objetos[userData_.body_B].life + enemys[userData_.body_A].damage

        enemys[userData_.body_A].life_number = enemys[userData_.body_A].life_number + objetos[userData_.body_B].damage
        enemys[userData_.body_A].life:set(tostring(enemys[userData_.body_A].life_number))
    end

end

function enemy:destroy()
    for i, _ in pairs(self) do
        self[i].body:destroy()
        -- self[i].fixture:destroy()

        -- table.remove(self, i)
        self[i] = nil
    end
    self = {}
end
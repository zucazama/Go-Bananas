enemy = {}
enemy.__index = enemy

enemys = setmetatable({}, enemy)
local cont = 0

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
        love.graphics.newImage('assets/png/banana.png'),
        }
    }

local template = {
    ['normal'] = {
        ['aurea'] = nil,
        ['damage'] = -30,
    },
    ['super'] = {
        ['aurea'] = nil,
        ['damage'] = -50,
    },
}

function enemy.new(type)

    cont = cont + 1
    
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    indexImage = math.random(#imagens)

    body = love.physics.newBody(world, math.random(_G.width), -(imagens[1][indexImage]:getHeight()), "dynamic")
    shape = love.physics.newRectangleShape(imagens[1][indexImage]:getWidth(), imagens[1][indexImage]:getHeight())
    fixture = love.physics.newFixture(body, shape, 1)

    body:setGravityScale(0.1)
    fixture:setRestitution(0)

    body:setUserData("enemy" .. cont)
    fixture:setUserData("enemy")

    -- table.insert(enemys, 
    enemys[body:getUserData()] = {
        ['body'] = body, 
        ['shape'] = shape, 
        ['fixture'] = fixture, 
        ['image'] = imagens[1][indexImage],
        ['life'] = love.graphics.newText(font.mullerNarrow.light.size[15], "100"),
        ['life_number'] = 100,
        ['damage'] = -30,
        ['scale'] = {
            ['x'] = 1,
            ['y'] = 1,
            }
        }
    --)
end

function enemy:newBoss()
    cont = cont + 1
    
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    -- indexCategory = math.random(#imagens)
    indexImage = math.random(#imagens[2])


    bodyX = math.random(_G.width)
    bodyY = -(imagens[2][indexImage]:getHeight())

    -- if type == "super" then
        x = (bodyX - objetos.steve.body:getX())
        y = (bodyY - objetos.steve.body:getY())
        local normVect = math.sqrt(x^2 + y^2)

        x = 100 * (x/normVect)
        y = 100 * (y/normVect)
    -- else
    --     x = 0
    --     y = 0
    -- end


    body = love.physics.newBody(world, bodyX, bodyY, "dynamic")
    shape = love.physics.newRectangleShape(imagens[2][indexImage]:getWidth(), imagens[2][indexImage]:getHeight())
    fixture = love.physics.newFixture(body, shape, 1)

    body:setGravityScale(0.4)
    body:setLinearVelocity(x, y)
    fixture:setRestitution(0)

    body:setUserData("enemy" .. cont)
    fixture:setUserData("enemy")

    -- table.insert(enemys, 
    enemys[body:getUserData()] = {
        ['body'] = body, 
        ['shape'] = shape, 
        ['fixture'] = fixture, 
        ['image'] = imagens[2][indexImage],
        ['life'] = love.graphics.newText(font.mullerNarrow.light.size[15], "150"),
        ['life_number'] = 150,
        ['damage'] = -50,
        ['aurea'] = nil,
        ['scale'] = {
            ['x'] = 1,
            ['y'] = 1,
            }
        }
    --)
end

function enemy:show()
    for i, _ in pairs(self) do
        if not self[i].body:isDestroyed() then
            love.graphics.setColor(255, 255, 255, 255)
            -- love.graphics.polygon("line", self[i].body:getWorldPoints(self[i].shape:getPoints()))
            love.graphics.draw(self[i].image, self[i].body:getX() - (self[i].image:getWidth()/2), self[i].body:getY() - self[i].image:getHeight()/2, self[i].body:getAngle(), self[i].scale.x, self[i].scale.y)
        
            -- love.graphics.draw()
            love.graphics.setColor(button.setColor"black%20")
            love.graphics.rectangle("fill", self[i].body:getX() + self[i].image:getHeight()/2 + 20 - 2, self[i].body:getY() - self[i].image:getHeight()/2 - 2, self[i].life_number + 4, 8)
            
            colorSelect = self[i].life_number >= 50 and "blue" or "red"
            love.graphics.setColor(button.setColor(colorSelect))
            love.graphics.rectangle("fill", self[i].body:getX() + self[i].image:getHeight()/2 + 20, self[i].body:getY() - self[i].image:getHeight()/2,  self[i].life_number, 5)
            
            -- love.graphics.setColor(255, 255, 255, 255)
            -- love.graphics.draw(self[i].life, self[i].body:getX() + self[i].image:getHeight()/2 + 25, self[i].body:getY() - self[i].image:getHeight()/2 )
        -- print(self[i].fixture:getUserData())
        end
    end
end

function enemy:update(dt)
    for i, _ in pairs(self) do
        if self[i].func then self[i].func(dt) end
    end
end

function enemy.collider(a, b)

    userData_ = {}

    if a:getUserData() == "enemy" or a:getUserData() == "enemyBoss" then
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

function enemy:explosition()
end

--[[
function enemy:effectScale(indx, dly)
    local index = indx
    local delay = 0
    local a = true
    local b = true

    return function(dt)
        if delay <= 0 then 
            if b then
                if a then 
                    self[index].scale.x = self[index].scale.x + 0.2
                    self[index].scale.y = self[index].scale.y + 0.2
                end

                if self[index].scale.x >= 1.4 or not a then
                    self[index].scale.x = self[index].scale.x - 0.2
                    self[index].scale.y = self[index].scale.y - 0.2

                    a = false

                    if self[index].scale.x == 1 then
                        b = false
                    end
                end
            else
                return true
            end

        delay = dly
        end

    delay = delay - dt

    end
end
--]]
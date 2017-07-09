weapons = {}
weapons.__index = weapons

bullet = {}

local cont = 1
local imageWeapons  = {
        ['axe'] = love.graphics.newImage("assets/png/axe.png"),
        ['hammer'] = love.graphics.newImage("assets/png/hammer.png"),
}

function weapons.new(type, x, y)

    body = love.physics.newBody(world, objetos.steve.body:getX(), objetos.steve.body:getY(), "dynamic")
    shape = love.physics.newRectangleShape(imageWeapons[type]:getWidth(), imageWeapons[type]:getHeight())
    fixture = love.physics.newFixture(body, shape, 0.5)
    body:setGravityScale(0.7)
    body:setUserData(type .. cont)
    fixture:setUserData(type)
    
    local CordX = (x - objetos.steve.body:getX())
    local CordY = (y - objetos.steve.body:getY())
    local normVect = math.sqrt(CordX^2 + CordY^2)

    CordX = CordX/normVect
    CordY = CordY/normVect

    body:applyLinearImpulse(100 * CordX, 100 * CordY)
    body:setAngularVelocity(5)

    -- table.insert(bullet, 
     bullet[body:getUserData()] = {
        ['body'] = body,
        ['shape'] = shape,
        ['fixture'] = fixture,
        ['type'] = type,
        ['damage'] = type == "axe" and -40 or -100,
    }
    -- )
    cont = cont + 1
end

function weapons.show()
    for i, _ in pairs(bullet) do
        if not bullet[i].body:isDestroyed() then
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(imageWeapons[bullet[i].type], bullet[i].body:getX() - (imageWeapons[bullet[i].type]:getWidth()/2), bullet[i].body:getY() - (imageWeapons[bullet[i].type]:getHeight()/2), bullet[i].body:getAngle())
        end
    end
end

function weapons.collider(a, b)
    userData_ = {}

    if a:getUserData() == "enemy" --[[or a:getUserData() == "enemyBoss"]] then
        userData_.body_A = a:getBody():getUserData()
        userData_.body_B = b:getBody():getUserData()
    else
        userData_.body_A = b:getBody():getUserData()
        userData_.body_B = a:getBody():getUserData()
    end   

    print(userData_.body_B)
    life.lost(bullet[userData_.body_B].damage, a:getBody():getPosition())

    -- print(userData_.body_B)
    -- print(cont)
    -- enemys[userData_.body_B]['func'] = enemys:effectScale(userData_.body_B, 0.5)

    if (enemys[userData_.body_A].life_number + bullet[userData_.body_B].damage) <= 0 then 
        enemys[userData_.body_A].body:destroy()
        -- enemys[userData_.body_A].fixture:destroy()
        enemys[userData_.body_A] = nil
    else
        enemys[userData_.body_A].life_number = enemys[userData_.body_A].life_number + bullet[userData_.body_B].damage
        enemys[userData_.body_A].life:set(tostring(enemys[userData_.body_A].life_number))
    end

    bullet[userData_.body_B].body:destroy()
    -- b:destroy()
    bullet[userData_.body_B] = nil
    -- table.remove(bullet, userData_.body_B)


--[[       
     -- text = text .. "\n" .. a:getUserData() .. " colliding with " .. b:getUserData()

        life.lost(bullet[userData_.body_B].damage, a:getBody():getPosition())

        if (enemys[userData_.body_A].life_number + bullet[userData_.body_B].damage) <= 0 then 
            a:getBody():destroy()
            -- a:destroy()

            enemys[userData_.body_A] = nil
        -- else
        --     enemys[userData_.body_A].life_number = enemys[userData_.body_A].life_number + bullet[userData_.body_B].damage
        --     enemys[userData_.body_A].life:set(tostring(enemys[userData_.body_A].life_number))
        end
        -- b:getBody():destroy()
        -- b:destroy()
        -- bullet[userData_.body_B] = nil
--]]
end
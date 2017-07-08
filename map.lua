map = {}

local background = love.graphics.newImage("bg.png")
local plataform = love.graphics.newImage("plataform.png")
local contactSound = love.audio.newSource("assets/audio/jump.wav", "static")
local contactSteve = love.audio.newSource("assets/audio/pop.mp3", "static")
function map.load()
    require "score"
    -- require "saveGame"
    
    -- if not love.filesystem.exists("save.lua") then saveGame.createSave(); end

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81 * 64, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    world:setContactFilter(
        function (a, b) 
            local userData_A = a:getUserData()
            local userData_B = b:getUserData() 

            if userData_A == "enemy" and userData_B == "enemy" then
                return false
            elseif userData_A == "steve" and userData_B == "axe" --[[or ( userData_A == "axe" or userData_A == "hammer" and userData_B == "steve")]] then
                return false

            elseif userData_A == "steve" and userData_B == "hammer" then
                return false
            elseif userData_A == "ground" and userData_B == "axe"  --[[or ( userData_A == "axe" or userData_A == "hammer" and userData_B == "ground")]] then
                return false
            elseif userData_A == "ground" and userData_B == "hammer" then
                return false
            else
                return true
            end
        end
    )

    local delay = 0.2


    objetos = {}
    objetos.ground = {}
    objetos.ground.body = love.physics.newBody(world, _G.width - 100, _G.height, "static")
    objetos.ground.shape = love.physics.newRectangleShape(_G.width, 100)
    objetos.ground.fixture = love.physics.newFixture(objetos.ground.body, objetos.ground.shape) 
    objetos.ground.fixture:setUserData("ground")

    objetos.steve = {
        ['body'] = love.physics.newBody(world, _G.width/2, _G.height/2, "dynamic"),
        ['shape'] = love.physics.newRectangleShape(40, 40),
        ['image'] = love.graphics.newImage('bat.png'),
        ['life'] = 100,
        ['damage'] = -100
    }
        objetos.steve.fixture = love.physics.newFixture(objetos.steve.body, objetos.steve.shape, 1)
    
    objetos.steve.fixture:setRestitution(0.6)
    objetos.steve.fixture:setFriction(0.7)
    objetos.steve.body:setUserData('steve')
    objetos.steve.fixture:setUserData('steve')
    --objetos.steve.body:setGravityScale(1)


    -- love.graphics.setBackgroundColor(105, 136, 258)
    --love.window.setMode(650, 650)

    text = ""   -- we'll use this to put info text on the screen later
    persisting = 0    -- we'll use this to store the state of repeated callback calls
    bodyContactA, bodyContactB = "" , ""
end 

function map.update(dt)
    world:update(dt) --this puts the world into motion
    life.update(dt)

    do
        if delay <= 0 then
            enemy.new()
            delay = 0.5
        end

        delay = delay - dt
    end
--[[
    contacts = world:getContactList()
    do
        a = {}
        for _, value in ipairs(contacts) do
            contactA, contactB = value:getFixtures()
            table.insert(a, {contactA:getUserData(),  contactB:getUserData()})
        end
        for i, value in ipairs(a) do
            if a[i][1] == 'ground' or a[i][2] == "circle" and a[i][2] == 'ground' or a[i][1] == "circle" then


    end
--]]
    --here we are going to create some keyboard events
       if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
        -- objetos.steve.body:applyForce(400, 0)
        -- objetos.steve.body:applyLinearImpulse(100, 0)
        objetos.steve.body:setLinearVelocity(200, 0)
        -- objetos.steve.body:applyAngularImpulse(10)
    end
    if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
        -- objetos.steve.body:applyForce(-400, 0)
        -- objetos.steve.body:applyLinearImpulse(-100, 0)
        objetos.steve.body:setLinearVelocity(-200, 0)
        -- objetos.steve.body:applyAngularImpulse(-10)
        -- objetos.steve.body:setAngularVelocity(math.rad(1))
    end
end

function map.show()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(background, 0, 0)
--[[
    do
        c = ""
        for _, value in ipairs(world:getContactList()) do
            fix1, fix2 = value:getFixtures()
            if fix1:getUserData() == "ground" and fix2:getUserData() == "steve" then
                isTouchingTheGround = true
                break
            else
                isTouchingTheGround = false
            end
        end

        love.graphics.print(c, 100, 100)
    end
--]]
        
        -- love.graphics.print(love.filesystem.getSaveDirectory() , love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    
    if (love.physics.getDistance(objetos.steve.fixture, objetos.ground.fixture)) > 400 then 
        local x, y  = objetos.ground.body:getX() - love.graphics.getWidth()/2, objetos.ground.body:getY() - love.graphics.getHeight() + 200 
        world:translateOrigin(x, y)
        
        -- objetos.steve.body:setPosition(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    else
          world:translateOrigin(objetos.steve.body:getX() - love.graphics.getWidth()/2, objetos.steve.body:getY() - love.graphics.getHeight()/2 - 200)
    end


    love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
    love.graphics.polygon("line", objetos.ground.body:getWorldPoints(objetos.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
    -- love.graphics.draw(plataform, objetos.ground.body:getX() - (plataform:getWidth()/2), objetos.ground.body:getY() - (plataform:getHeight()/2))

    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.polygon("fill", objetos.steve.body:getWorldPoints(objetos.steve.shape:getPoints()))
    
    enemys:show()
    
    love.graphics.draw(objetos.steve.image, objetos.steve.body:getX(), objetos.steve.body:getY(), objetos.steve.body:getAngle(), 1, 1)

    love.graphics.print(text, 10, 10)
    -- love.graphics.print(bodyContactA, 100, 10)
    
end


function map.keypressed(key) 


    -- if isTouchingTheGround then 
        if key == "w" then --press the up arrow key to set the ball in the air
            -- objetos.steve.body:setPosition(650/2, 650/2)
            objetos.steve.body:applyLinearImpulse(0, -100) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
        end
        if key == "s" then
            objetos.steve.body:applyLinearImpulse(0, 100)
        end
    -- end
end

function beginContact(a, b, coll)
    x, y = coll:getNormal()
    bodyContactA, bodyContactB = coll:getFixtures()
    
    local userData_Fixture_A = a:getUserData()
    local userData_Fixture_B = b:getUserData()
    
    -- print(tostring(userData_Fixture_A), tostring(userData_Fixture_B))

    local index_A = (a:getBody():getUserData())
    local index_B = (b:getBody():getUserData())
    -- text = text .. "\n" .. a:getUserData() .. " colliding with " .. b:getUserData()
    
    if userData_Fixture_A == "ground" and userData_Fixture_B == "enemy" then
        
        -- table.remove(enemys, tonumber(b:getBody():getUserData()))
        b:destroy()
        -- b:getBody():destroy()
        enemys[index_B] = nil
        -- isTouchingTheGround = true
    elseif (userData_Fixture_A == "steve" and userData_Fixture_B == "enemy") or (userData_Fixture_A == "enemy" and userData_Fixture_B == "steve") then
        contactSteve:play()
        enemy.collider(a, b)
    elseif (userData_Fixture_A == "enemy" and userData_Fixture_B == "axe") or (userData_Fixture_A == "axe" and userData_Fixture_B == "enemy") then
        contactSound:play()
        -- text = text .. "\n" .. a:getUserData() .. " colliding with " .. b:getUserData()
        weapons.collider(a, b)
        -- isTouchingTheGround = false
    elseif (userData_Fixture_A == "enemy" and userData_Fixture_B == "hammer") or (userData_Fixture_A == "hammer" and userData_Fixture_B == "enemy") then
        contactSound:play()
        weapons.collider(a, b)
    end
end
 
function endContact(a, b, coll)
    persisting = 0
    -- text = text .."\n".. a:getUserData() .. " uncolliding with ".. b:getUserData()
end
 
function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        -- text = 'preSolve'
        -- text = text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        -- text = text.." "..persisting
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
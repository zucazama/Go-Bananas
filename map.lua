map = {}

local delay = 0.5

local tilesGround = {}
local elementsGround = {}

function map.load()
    require "overlap"
    -- require "saveGame"
    -- if not love.filesystem.exists("save.lua") then saveGame.createSave(); end
    

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81 * 64, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    world:setContactFilter(function (a, b) return true end)


    objetos = {}
    objetos.ground = {}
    objetos.ground.body = love.physics.newBody(world, _G.width/2, _G.height, "static")
    objetos.ground.shape = love.physics.newRectangleShape(_G.width, 300)
    objetos.ground.fixture = love.physics.newFixture(objetos.ground.body, objetos.ground.shape) 
    objetos.ground.body:setUserData("ground")
    objetos.ground.fixture:setUserData("ground")
    
    map.createGround(_G.width, 300, 0, objetos.ground.body:getY() - 150)
    map.createElements(0, objetos.ground.body:getY() - 150)

    -- enemy.create()
    enemy.load()
end 

function map.createGround(width, height, x, y)
    local w = math.floor(width/ui.image['box1']:getWidth()) + 3
    local h = math.floor(height/ui.image['box1']:getHeight()) + 3
    local xi = x - 2
    local yi = y - 2 

    for i = 1, h do
        xi = x

        for j = 1, w do
            if i == 1 then
                table.insert(tilesGround, {
                    ['image'] = "box1",
                    ['position'] = {
                        ['x'] = xi,
                        ['y'] = yi
                    }
                }) 
            else
            table.insert(tilesGround, {
                    ['image'] = "box2",
                    ['position'] = {
                        ['x'] = xi,
                        ['y'] = yi,
                    }
                }) 
            end

        xi = xi + ui.image['box1']:getWidth() - 2
        end

        yi = yi + ui.image['box1']:getHeight() - 2
    end
end

function map.showGround()
    for i = 1, #tilesGround do
        love.graphics.draw(ui.image[tilesGround[i].image], tilesGround[i].position.x, tilesGround[i].position.y)
    end
end

function map.createElements(x, y)
    -- Gera os objetos que devem está a cima do chão
    local treeRandom = math.random(4)

    for i = 1, treeRandom do
        local tree = math.random(3)
        table.insert(elementsGround, {
            ['image'] = "tree" .. tree,
            ['position'] = {
                ['x'] = math.random(_G.width - 200),
                ['y'] = y - ui.image["tree" .. tree]:getHeight()

            }
        })
    end

    table.insert(elementsGround, {
        ['image'] = "scarecrow",
        ['position'] = {
            ['x'] = math.random(_G.width - 200),
            ['y'] = y - ui.image['scarecrow']:getHeight()

        }
    })
end
    
function map.showElements()
    for i = 1, #elementsGround do
        love.graphics.draw(ui.image[elementsGround[i].image], elementsGround[i].position.x, elementsGround[i].position.y)
    end
end


function map.update(dt)
    world:update(dt)
    overlap.update(dt)

    do
        if delay <= 0 then
            enemy.new()
            delay = 0.9
        end

        delay = delay - dt
    end

    enemys:update(dt)
end

function map.show()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(ui.image.background, 0, 0, 0, 0.2, 0.2)
    map.showGround()
    map.showElements()

    love.graphics.setColor(72, 160, 14)
    love.graphics.polygon("line", objetos.ground.body:getWorldPoints(objetos.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
  
    enemys:show()
    
end


function map.keypressed(key) 
end

function map.mousepressed(x, y, key)
    enemy.collider2(x, y)
end

function beginContact(a, b, coll)
    enemy.collider(a, b)
end
 
function endContact(a, b, coll)
end
 
function preSolve(a, b, coll)
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end

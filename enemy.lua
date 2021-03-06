enemy = {}
enemy.__index = enemy

enemys = setmetatable({}, enemy)


local cont = 0
local typeFruits = {'orange', 'pineapple' , 'tomato', 'apple', 'lemon', 'pumpkin', 'strawberry'}

local columnAvailableForChoose = {}
local discardedColumns = {}

local typeFruits_numberRequied = {}
local fruitsValuesAvailable = {}

positions = {}



_G.fruits = {
    {
    -- Fruits
    love.graphics.newImage("assets/png/fruitsIcons/@64px/tomato.png" ),
    ['orange'] = love.graphics.newImage("assets/png/fruitsIcons/@64px/orange.png"),
    ['pineapple'] = love.graphics.newImage("assets/png/fruitsIcons/@64px/pineapple.png"),
    ['tomato'] = love.graphics.newImage("assets/png/fruitsIcons/@64px/tomato.png"),
    ['apple'] = love.graphics.newImage("assets/png/fruitsIcons/@64px/apple.png"),
    ['lemon'] = love.graphics.newImage("assets/png/fruitsIcons/@64px/tomato.png"),
    ['pumpkin'] = love.graphics.newImage("assets/png/fruitsIcons/@64px/pumpkin.png"),
    
    },
}

function enemy:createEmptyTab(n)
    for i = 1, n * 2 do
        self[i] = {['n'] = 0}
        columnAvailableForChoose[i] = i
    end 
end

function enemy.create()

    math.randomseed(tonumber(os.date("%S")) * os.clock())

    numberFruitChoose = #typeFruits > 5 and math.random(5) or math.random(#typeFruits)
    typeFruits_availableForChoose = {table.unpack(typeFruits)}
    typeFruits_choose = {table.unpack(typeFruits)}

    for _, v in ipairs(typeFruits) do fruitsValuesAvailable[v] = 0 end

    values = enemy.createRequiredAndAvailableValues(numberFruitChoose)
    enemy.randomNumber(numberFruitChoose)
end


function enemy.createRequiredAndAvailableValues(n) 
    local values = {}
    local sumAvailable = 0
    local sumRequied = 0


    for i = 1, n do
        local typeNumberRandom_available = math.random((7 * #positions) + 10)
        local typeNumberRandom_number = math.random(typeNumberRandom_available)
        table.insert(values, {
            ['available'] = typeNumberRandom_available, 
            ['requied'] = typeNumberRandom_number
            })

    end

    for i = 1, #values do
        sumAvailable = sumAvailable + values[i].available
        sumRequied = sumRequied + values[i].requied
    end
    
    if sumRequied < math.floor(sumAvailable/2) or sumRequied > (7 * #positions) then
        -- print"Entrou aqui quantas vezes"
        return enemy.createRequiredAndAvailableValues(n)
    else
        return values
    end

end


function enemy.randomNumber(n)
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    local typeNumberRandom = math.random(#typeFruits_choose)
    
    if n == 0 then return
    else
        assert(typeFruits_choose[typeNumberRandom], typeNumberRandom)
        -- Gera a barra lateral que contém as frutas e suas respectivas quantidades
        score.new(typeFruits_choose[typeNumberRandom], values[n].requied, values[n].available, love.graphics.newImage("assets/png/fruitsIcons/@64px/" .. typeFruits_choose[typeNumberRandom] .. ".png"))
        
        -- Implimeta as quantidades de caixas disponíveis 
        -- print("frutas selecionadas ", typeFruits_choose[typeNumberRandom])
        boxFruitsInContact[typeFruits_choose[typeNumberRandom]] = values[n].available
        
        -- fruitsValuesAvailable[typeFruits_choose[typeNumberRandom]] = values[n].available
        
        table.remove(typeFruits_choose, typeNumberRandom)

        -- typeFruits_numberRequied[typeFruits_choose[typeNumberRandom]] = {['necessary'] = typeNumberRandom_requied, [''] } )
        enemy.randomNumber(n-1)

    end
end


function enemy.repeatyRandom()
    if #columnAvailableForChoose == 0 then return false end
    
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    
    -- Sorteia um index entre os disponiveis
    local columnRandomSelect = math.random(#columnAvailableForChoose)
    
    -- Fileira a qual o objeto deve ser criado
    local columnRandom = columnAvailableForChoose[columnRandomSelect] -- Possui o index da posição da coluna sorteada


    if not columnRandom then return false 
        elseif enemys[columnRandom]['n'] == 7 then

            table.remove(columnAvailableForChoose, columnRandomSelect)
            table.insert(discardedColumns, columnRandom)
        
            return enemy.repeatyRandom()
    else 
        return columnRandom  
    end
        
end

function enemy.new(type)

    cont = cont + 1
    
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    if #discardedColumns > 1 then enemy.checkColumn() end
    local columnRandom = enemy.repeatyRandom()
    
    if not whatIsVisible.winOrLose then 
        winOrLose.waysToWinOrLose(); 
    end
   
    if not columnRandom then return true end

    local typeRandomNumber = math.random(#typeFruits_availableForChoose)
    local typeRandom = typeFruits_availableForChoose[typeRandomNumber]
    
    if not typeRandom then return true end

    local image = love.graphics.newImage("assets/png/fruitsIcons/@64px/" .. typeRandom .. ".png" )
    -- local columnRandom = math.random(#positions)
    -- print("Quantidade de total de frutas no chao", boxFruitsInContact.n)
    
    fruitsValuesAvailable[typeRandom] = --[=[ not fruitsValuesAvailable[typeFruits_availableForChoose[typeRandomNumber]] and 1 or ]=] fruitsValuesAvailable[typeFruits_availableForChoose[typeRandomNumber]] + 1
 

    score.updateLabelNumberAvailable(typeRandom)
    
    enemys[columnRandom].n = enemys[columnRandom].n + 1

    -- Cria objetos de determinado tipo no mundo
    body = love.physics.newBody(world, positions[columnRandom].x, positions[columnRandom].y, "dynamic")
    shape = love.physics.newRectangleShape(image:getWidth(), image:getHeight())
    fixture = love.physics.newFixture(body, shape, 1)

    body:setGravityScale(0.2)
    body:setLinearDamping(0.2)
    body:setFixedRotation(true)
    -- body:setMassData(x, y, 10, 100)
    -- body:setInertia(1)

    fixture:setFriction(1)
    fixture:setRestitution(0.1)
    
    cont = cont + 1
    
    body:setUserData(columnRandom .. ":" .. cont)
    fixture:setUserData(typeRandom)

    enemys[columnRandom][body:getUserData()] = {
        ['body'] = body, 
        ['shape'] = shape, 
        ['fixture'] = fixture, 
        ['image'] = image,
        ['number'] = love.graphics.newText(font.mullerNarrow.extraBold.size['20'], fruitsValuesAvailable[typeRandom]),
        ['collider'] = false,
        ['scale'] = {
            ['x'] = 1,
            ['y'] = 1,
            }
        }
end


function enemy:show()
    for i, _ in pairs(self) do
        for j, _ in pairs(self[i]) do
            if j ~= "n" then                 
                if not self[i][j].body:isDestroyed() then
                    
                    love.graphics.setColor(255, 255, 255, 255)
                    love.graphics.draw(self[i][j].image, self[i][j].body:getX(), self[i][j].body:getY(), self[i][j].body:getAngle(), 1, 1, (self[i][j].image:getWidth()/2), (self[i][j].image:getHeight()/2))
                
                    love.graphics.setColor(0, 0, 0, 200)
                    love.graphics.polygon("line", self[i][j].body:getWorldPoints(self[i][j].shape:getPoints()))
                end

            end
        end
    end

    for i, _ in pairs(self) do
        for j, _ in pairs(self[i]) do
            if j ~= "n" then 
                if not self[i][j].collider then
                    love.graphics.setColor(button.setColor("black%20"))
                    love.graphics.circle("fill", self[i][j].body:getX() + (self[i][j].image:getWidth()/2), self[i][j].body:getY() - (self[i][j].image:getHeight()/2), self[i][j].number:getHeight() + 2, 200)
                    
                    love.graphics.setColor(button.setColor("red"))
                    love.graphics.circle("fill", self[i][j].body:getX() + (self[i][j].image:getWidth()/2), self[i][j].body:getY() - (self[i][j].image:getHeight()/2), self[i][j].number:getHeight(), 200)
                
                    love.graphics.setColor(0, 0, 0, 40)
                    love.graphics.draw(self[i][j].number, self[i][j].body:getX() + (self[i][j].image:getWidth()/2) - self[i][j].number:getWidth()/2 + 2, self[i][j].body:getY() - (self[i][j].image:getHeight()/2) - self[i][j].number:getHeight()/2 + 2)
                    
                    love.graphics.setColor(button.setColor("white"))
                    love.graphics.draw(self[i][j].number, self[i][j].body:getX() + (self[i][j].image:getWidth()/2) - self[i][j].number:getWidth()/2, self[i][j].body:getY() - (self[i][j].image:getHeight()/2) - self[i][j].number:getHeight()/2)
                    
                end
            end
        end
    end
end

function enemy:update(dt)
end

function enemy.load()
    enemy.positionRespanw(math.floor(_G.width/fruits[1][1]:getWidth())/2 - 4 , fruits[1][1]:getWidth())
    enemys:createEmptyTab(math.floor(_G.width/fruits[1][1]:getWidth())/2 - 4)
    enemy.create()
end

function enemy:checkColumn()
    if boxFruitsInContact.n <= (7 * #positions) then 
        for k, _ in pairs(enemys) do
            if enemys[k].n <= 7 then
                for y, v in ipairs(discardedColumns) do
                    if v == k then
                        table.insert(columnAvailableForChoose, v)
                        table.remove(discardedColumns, y)
                    end
                end
            end
        end
    end
end


function enemy.collider(a, b)

    local userData_ = {}

    userData_.fixture_A = a:getUserData()
    userData_.fixture_B = b:getUserData()

    userData_.body_A = a:getBody():getUserData()
    userData_.body_B = b:getBody():getUserData()
    

    userData_.index_A = tonumber(userData_.body_A:match("^(%d+)"))
    userData_.index_B = tonumber(userData_.body_B:match("^(%d+)"))
    -- print(userData_.body_A, userData_.index_A)
    -- print(userData_.body_B, userData_.index_B)

    if userData_.fixture_A == "ground" and (not enemys[userData_.index_B][userData_.body_B].collider) then
        -- overlap.lost(ui.image.add, enemys[userData_.index_B][userData_.body_B].body:getX(), enemys[userData_.index_B][userData_.body_B].body:getY(), 0.04)
        enemys[userData_.index_B][userData_.body_B].collider = true
        ui.sound.contactWithGround:play()
        score.updateLabelNumber(userData_.fixture_B, userData_.index_B, userData_.body_B)

    elseif userData_.fixture_B == "ground" and (not enemys[userData_.index_A][userData_.body_A].collider) then
        -- overlap.lost(ui.image.add, enemys[userData_.index_A][userData_.body_A].body:getX(), enemys[userData_.index_A][userData_.body_A].body:getY(), 0.04)
        enemys[userData_.index_A][userData_.body_A].collider = true
        ui.sound.contactWithGround:play()
        score.updateLabelNumber(userData_.fixture_A, userData_.index_A, userData_.body_A)
    end

    if not (userData_.fixture_A == "ground") and not (userData_.fixture_B == "ground") then
        if enemys[userData_.index_A][userData_.body_A].collider and not enemys[userData_.index_B][userData_.body_B].collider then
            enemys[userData_.index_B][userData_.body_B].collider = true
            -- overlap.lost(ui.image.add, enemys[userData_.index_B][userData_.body_B].body:getX(), enemys[userData_.index_B][userData_.body_B].body:getY(), 0.04)
            ui.sound.contactWithGround:play()

            score.updateLabelNumber(userData_.fixture_B, userData_.index_B, userData_.body_B)

        elseif
            enemys[userData_.index_B][userData_.body_B].collider and not enemys[userData_.index_A][userData_.body_A].collider then
            enemys[userData_.index_A][userData_.body_A].collider = true
        
            -- overlap.lost(ui.image.add, enemys[userData_.index_A][userData_.body_A].body:getX(), enemys[userData_.index_A][userData_.body_A].body:getY(), 0.04)
            ui.sound.contactWithGround:play()
            score.updateLabelNumber(userData_.fixture_A, userData_.index_A, userData_.body_A)
        end
    end

    enemy:checkColumn()
end


function enemy.restart()
    cont = 0
    fruitsValuesAvailable = {}
    enemys:destroy()
    score.load()
    enemy.load()
end

function enemy:destroy()
    for i, _ in pairs(self) do
        for j, _ in pairs(self[i]) do
            if j ~= "n" then 

            self[i][j].body:destroy()
            self[i][j] = nil

            end
        end
        self[i] = nil
    end

    self = {}
end


function enemy.collider2(x, y)
    for i, _ in pairs(enemys) do
        -- print(x, y)
        for j, _ in pairs(enemys[i]) do
            if not (j == "n") and not enemys[i][j].collider then
                if enemys[i][j].shape:testPoint(enemys[i][j].body:getX(), enemys[i][j].body:getY(), enemys[i][j].body:getAngle(), x, y) then
                    ui.sound.contactWithMouse:play()
                    
                    enemy:checkColumn()
                    overlap.lost(ui.image.delete, x, y, 0.04)
                    
                    -- boxFruitsInContact.n = boxFruitsInContact.n + 1

                    if boxFruitsInContact[enemys[i][j].fixture:getUserData()] then 
                        boxFruitsInContact[enemys[i][j].fixture:getUserData()] = boxFruitsInContact[enemys[i][j].fixture:getUserData()] - 1 
                    end  


                    enemys[i].n = enemys[i].n - 1 
                    enemys[i][j].body:destroy()
                    enemys[i][j] = nil
 
                
                end
            end
        end
    end
end



function enemy.positionRespanw(n, width)
    positions = {}
    
    local positionStart = (_G.width/2) - ((n - 1) *  width + (width/2) + (n - 1) * 4)
    
    for i = 1, n * 2 do
        table.insert(positions, {
            ['x'] = positionStart + (i - 1) * (width + 4),
            ['y'] = -(width * 2),
        })
    end

end

-- enemy.positionRespanw(math.floor(_G.width/fruits[1][1]:getWidth())/2 - 4 , fruits[1][1]:getWidth())
-- enemys:createEmptyTab(math.floor(_G.width/fruits[1][1]:getWidth())/2 - 4)

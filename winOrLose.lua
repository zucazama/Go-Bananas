win = {}
lose = {}
winOrLose = {}
winOrLose.__index = winOrLose
winOrLoseButtons = setmetatable({}, winOrLose)

local margens = 40

frases = {
    ['lose'] = {
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Não consegue neh?"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Se quiser... deixo-lhe tentar uma última vez"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Perdeu! perdedor"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Que vacilão!"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Deveria tentar fazer outra coisa #dica"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "!$%#*%§!"),
    },
    ['win'] = {
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Parabéns!"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Não fez mas do que seu trabalho!"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Sempre acreditei"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "Sabia desde o princípio"),
        love.graphics.newText(font.mullerNarrow.extraBold.size['40'], "aahahhaah, Extamente como pedi!"),
    },
}

local chooseFrasesNumber = {}


function win.isWin()
    chooseFrasesNumber = {}
    whatIsVisible.menuButtons = false;
    whatIsVisible.score = false
    whatIsVisible.start = true
    whatIsVisible.winOrLose = true
    whatIsVisible.userBar = false
    chooseFrases = winOrLose.createFrasesForShow(winOrLose.chooseFrase('win', math.random(3)))
    ui.sound.win:play()
end

function lose.isLose()
    chooseFrasesNumber = {}
    whatIsVisible.menuButtons = false;
    whatIsVisible.score = false
    whatIsVisible.start = true
    whatIsVisible.winOrLose = true
    whatIsVisible.userBar = false
    chooseFrases = winOrLose.createFrasesForShow(winOrLose.chooseFrase('lose', 2))
    ui.sound.lose:play()
end
   

function winOrLose.createFrasesForShow(...)
    local label = {}

    for _, v in ipairs{...} do
        table.insert(label, {
            ['text'] = v,
            ['position'] = {
                ['x'] = _G.width/2,
                ['y'] = #label > 0 and label[#label].position.y + label[#label].text:getHeight() + 10 or 100,
            }
        })
    end

    return label
end

function winOrLose.waysToWinOrLose()

    local sumNumberAvailable = 0
    local sumNumberRequied = 0
    local a = false

    -- print("dentro do lose")

    for i, v in ipairs(scoreButton) do
        sumNumberAvailable =  sumNumberAvailable + scoreButton[i]['type'].label.number
        sumNumberRequied = sumNumberRequied + scoreButton[i]['score'].label.number
                -- print(scoreButton[i]['type'].label.number, boxFruitsInContact[scoreButton[i]['type'].type])
        if scoreButton[i]['type'].label.number == 0 and boxFruitsInContact[scoreButton[i]['type'].type] == 0 then
            
            if scoreButton[i]['type'].label.number < scoreButton[i]['score'].label.number then 
                print"motivo 1: Quantidade disponivel insuficiente"
                lose.isLose() 
                return
                
            elseif scoreButton[i]['score'].label.number > 0 then 
                print"motivo 2: quantidade necessária não alcançada"
                lose.isLose()
                return 
                
            end
        else
            a = true
        end
        if scoreButton[i]['score'].label.number < 0 then 
            print"motivo 3: Quantiade maior do que o requerido"
            lose.isLose() 
            return
            
        end
    end
    
    -- print(sumNumberRequied, "soma de numeros requeridos", #positions)
    
    if sumNumberRequied > math.abs((7 * #positions) - boxFruitsInContact.n) then  
        print"motivo 4: Não há espaço suficiente disponível para as frutas que faltam"
        lose.isLose();
        return
    -- end

    elseif sumNumberAvailable == 0 and sumNumberRequied == 0 and not a then 
        print("Ganhou pelo motivo: Quantidade necessaria alcançada")
        win.isWin() 
        return
    elseif boxFruitsInContact.n == (7 * #positions) and sumNumberRequied == 0 then
        print("Ganhou pelo motivo: Chegou ao final e cumpriu todos os requitos para não peder")
        win.isWin()
        return
    end
end


function winOrLose.show(frases)
    
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.rectangle("fill", 0, 0, _G.width, _G.height)

    for i, _ in ipairs(frases) do
        love.graphics.setColor(0, 0, 0, 20)
        love.graphics.draw(frases[i].text, frases[i].position.x + 2, frases[i].position.y + 2, 0, 1, 1, frases[i].text:getWidth()/2, frases[i].text:getHeight()/2)
        
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(frases[i].text, frases[i].position.x, frases[i].position.y, 0, 1, 1, frases[i].text:getWidth()/2, frases[i].text:getHeight()/2)
    end
end


function winOrLose.chooseFrase(type, n)
    math.randomseed(tonumber(os.date("%S")) * os.clock())
    local a = false
    local choose = math.random(#frases[type])

    for _, v in ipairs(chooseFrasesNumber) do
        if v == choose then
            a = true
            return winOrLose.chooseFrase(type, n)
        end
    end

    if not a then
        if n == 1 then return frases[type][choose]
        else
            table.insert(chooseFrasesNumber, choose)
            return frases[type][choose], winOrLose.chooseFrase(type, n - 1)
        end
    end
end


function winOrLose:newButton(text, icon, func, color,  n)

    
    local title = love.graphics.newText(font.mullerNarrow.extraBold.size['30'], text)
        
    -- local position = {
    --     ['x'] = #self ~= 0 and self[#self].rectangle.position.x + self[#self].rectangle.size.width + margens - 10 or 60,
    --     ['y'] = height/2 - 100
    -- }

    local image = {
        ['icon'] = icon or love.graphics.newImage("assets/png/ui/png/pause.png"),
    }
        
    local rectangle = { 
        ['position'] = {
            ['x'] = #self ~= 0 and self[#self].rectangle.position.x + self[#self].rectangle.size.width + margens/2 or _G.width/2 - n/2 * (image.icon:getWidth() + margens) ,
            ['y'] = _G.height/2
        },
        ['size'] = {
            ['width'] = title:getWidth() < image.icon:getWidth() and image.icon:getWidth() + margens or title:getWidth() + margens + 20,
            -- height = title:getHeight() + margens
            ['height'] = 250
        },
    }

    local position = {
            ['x'] = rectangle.position.x + (math.abs(rectangle.size.width - title:getWidth())/2) + title:getWidth()/2,
            ['y'] = rectangle.position.y + (title:getHeight() + margens/2)/2
    }

    image['position'] = {
        ['x'] = rectangle.position.x + math.abs((image.icon:getWidth() - rectangle.size.width)/2),  
        ['y'] = (rectangle.position.y + title:getHeight() + margens/2 )+ math.abs((image.icon:getHeight() - (rectangle.size.height - (title:getHeight() + margens/2)))/2),
    }
    

    table.insert(self, setmetatable(
        {
        ['label'] = text,
        ['title'] = title,
        ['image'] = image,
        ['position'] = position,
        ['rectangle'] = rectangle,
        ['action'] = func,
        ['color'] = {['defalt'] = color or 'defalt', ['select'] = 'select'},
        ['select'] = false,
        ['isLocked'] = isLocked or false,
        ['escale'] = {['x'] = 1, ['y'] = 1},

        }, winOrLose))

end

function winOrLose:showButtons()
    for i, _ in pairs(self) do
            love.graphics.setColor(0, 0, 0, 10)
            love.graphics.rectangle('fill', self[i].rectangle.position.x - 2, self[i].rectangle.position.y - 2, self[i].rectangle.size.width + 4, self[i].rectangle.size.height + 4)

            love.graphics.setColor(0, 0, 0, 50)
            love.graphics.rectangle('fill', self[i].rectangle.position.x, self[i].rectangle.position.y, self[i].rectangle.size.width, self[i].rectangle.size.height)
            
            love.graphics.setColor(button.setColor(self[i].color.defalt))
            love.graphics.rectangle("fill", self[i].rectangle.position.x, self[i].rectangle.position.y, self[i].rectangle.size.width, self[i].title:getHeight() + margens/2)

            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(self[i].image.icon, self[i].image.position.x, self[i].image.position.y)

            -- Sombra do titulo do botão
            love.graphics.setColor(0, 0, 0, 40)
            love.graphics.draw(self[i].title, self[i].position.x + 2, self[i].position.y + 2, 0, 1, 1, self[i].title:getWidth()/2, self[i].title:getHeight()/2)
            
            -- Título do botão
            love.graphics.setColor(255, 255, 255, 240)
            love.graphics.draw(self[i].title, self[i].position.x, self[i].position.y, 0, 1, 1, self[i].title:getWidth()/2, self[i].title:getHeight()/2)
            

            if self[i].isLocked then
                love.graphics.setColor(0, 0, 0, 10)
                love.graphics.rectangle('fill', self[i].rectangle.position.x + self[i].rectangle.size.width - 32, self[i].rectangle.position.y, 32, 44)
                

                love.graphics.setColor(255, 255, 255, 240)
                love.graphics.rectangle('fill', self[i].rectangle.position.x + self[i].rectangle.size.width - 30, self[i].rectangle.position.y, 30, 40)          
                
                love.graphics.setColor(255, 255, 255, 255)
                love.graphics.draw(ui.image.locked, self[i].rectangle.position.x + self[i].rectangle.size.width - 23, self[i].rectangle.position.y + 12, 0, 1, 1)
            
            end

            if self[i].select then
                -- Retangulo de seleção do botão
                love.graphics.setColor(0, 0, 0, 200)
                love.graphics.rectangle('line', self[i].rectangle.position.x, self[i].rectangle.position.y, self[i].rectangle.size.width, self[i].rectangle.size.height)
            end
    end
end

function winOrLose:buttonHouver(x, y)

    for i, _ in pairs(self) do
        if x > self[i].rectangle.position.x and x < (self[i].rectangle.position.x + self[i].rectangle.size.width) and y > self[i].rectangle.position.y and y < (self[i].rectangle.position.y + self[i].rectangle.size.height) then
            --font = love.graphics.setNewFont(50)
            -- self[i].color = {button.setColor('select')}
            self[i].select = true
            -- selfelect = i
            if (self[i].title:getFont()):getHeight() ~= 40 then 
                self[i].title:setFont(font.mullerNarrow.extraBold.size['40'])
            end
        else
            self[i].select = false
            -- love.graphics.setBackgroundColor(255, 255, 100)
            if (self[i].title:getFont()):getHeight() ~= 30 then 
                self[i].title:setFont(font.mullerNarrow.extraBold.size['30']) end
            -- self[i].color = {button.setColor('defalt')}
        end

    end
end

function winOrLose:onClick(x, y, key)
    if key == 1 then
        for i, _ in ipairs(self) do
            if self[i].title then
                if x > self[i].rectangle.position.x and x < (self[i].rectangle.position.x + self[i].rectangle.size.width) and y > self[i].rectangle.position.y and y < (self[i].rectangle.position.y + self[i].rectangle.size.height) then
                    self[i].action()
                end
            end
        end
    end
end
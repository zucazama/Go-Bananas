score = {}
score.__index = index

index_Type = {}
scoreButton = setmetatable({}, score)


margens = 20
boxFruitsInContact = {['n'] = 0, }

function score.load()
    index_Type = {}
    scoreButton = setmetatable({}, score)
    boxFruitsInContact = {['n'] = 0,}


end

function  score.new(type, num, numberRequired, icon)
        image = { 
            ['icon'] = icon,
        }

        minilabel = {
            ['text'] = love.graphics.newText(font.mullerNarrow.light.size['20'], tostring(numberRequired)),
            ['number'] = numberRequired
        }

        label = {
            ['text'] = love.graphics.newText(font.mullerNarrow.extraBold.size['30'], tostring(num)),
            ['number'] = num,
        }

        boxIcon = {
            ['position'] = {
                ['x'] = --[[ #scoreButton > 0 and scoreButton[#scoreButton].box.position.x - (image.icon:getWidth() + margens) or ]] _G.width - (40 + image.icon:getWidth() + margens),
                ['y'] = #scoreButton > 0 and scoreButton[#scoreButton]['type'].box.position.y + (image.icon:getHeight() + margens) + 5 or 60
            },
            ['size'] = {
                ['width'] = margens + image.icon:getWidth(),
                ['height'] = margens + image.icon:getHeight(),
            }
        }

        boxNumber = {
            ['position'] = {
                ['x'] = boxIcon.position.x - (margens + label.text:getWidth()),
                ['y'] = boxIcon.position.y,
            },
            ['size'] = {
                ['width'] = margens + label.text:getWidth(),
                ['height'] = boxIcon.size.height,
            }
        }


        label.position = {
            ['x'] = boxNumber.position.x + (math.abs(boxNumber.size.width - label.text:getWidth())/2),
            ['y'] = boxIcon.position.y + (math.abs(boxNumber.size.height - label.text:getHeight())/2),
        }

        image['position'] = {
            ['x'] = boxIcon.position.x + (math.abs(boxIcon.size.width - image.icon:getWidth())/2),
            ['y'] = boxIcon.position.y + (math.abs(boxIcon.size.height - image.icon:getHeight())/2),
        }

        
        minilabel['box'] = {
            ['position'] = {
                ['x'] = boxIcon.position.x + boxIcon.size.width - minilabel.text:getWidth() - margens/2,
                ['y'] = boxIcon.position.y,
                },
            ['size']  = {
                ['width'] = minilabel.text:getWidth() + margens/2,
                ['height'] = minilabel.text:getHeight() + margens/2,
                },
            }

        minilabel['position'] = {
            ['x'] = minilabel.box.position.x + (math.abs(minilabel.box.size.width - minilabel.text:getWidth())/2),
            ['y'] = minilabel.box.position.y + (math.abs(minilabel.box.size.height - minilabel.text:getHeight())/2),
        }

    table.insert(scoreButton, { 
        ['type'] = {
            ['image'] = image,
            ['box'] = boxIcon,
            ['label'] = minilabel,
            ['color'] = {
            ['defalt'] = color or "white%20"},
            ['type'] = type,
        },
        ['score'] = {
            ['label'] = label,
            ['box'] = boxNumber,           
            ['color'] = {
            ['defalt'] = color or "white%20"},
            ['select'] = {},

        },
    })

    index_Type[type] = #scoreButton

end

function score.updateLabelNumberAvailable(type, num)
    if index_Type[type] then
        
        scoreButton[index_Type[type]]['type'].label.number = scoreButton[index_Type[type]]['type'].label.number - (num or 1)    
        scoreButton[index_Type[type]]['type'].label.text:set(scoreButton[index_Type[type]]['type'].label.number)

        if scoreButton[index_Type[type]]['type'].label.number == 0 then score.findValue(type) end -- Exclui uma determinada fruta das possibilidades de escolha para gerar novas

        scoreButton[index_Type[type]]['type'].label.box.position.x = scoreButton[index_Type[type]]['type'].box.position.x + scoreButton[index_Type[type]]['type'].box.size.width - scoreButton[index_Type[type]]['type'].label.text:getWidth() - margens/2
        scoreButton[index_Type[type]]['type'].label.box.size.width = margens/2 + scoreButton[index_Type[type]]['type'].label.text:getWidth()
        scoreButton[index_Type[type]]['type'].label.position.x = scoreButton[index_Type[type]]['type'].label.box.position.x + (math.abs(scoreButton[index_Type[type]]['type'].label.box.size.width - scoreButton[index_Type[type]]['type'].label.text:getWidth())/2)
    end
end

function score.updateLabelNumber(type, indexBody, userDataBody)
    overlap.lost(ui.image.add, enemys[indexBody][userDataBody].body:getX(),  enemys[indexBody][userDataBody].body:getY())
    
    boxFruitsInContact.n = boxFruitsInContact.n + 1  
    
    if index_Type[type] then
        boxFruitsInContact[type] = boxFruitsInContact[type] - 1
        -- print("quantas frutas já foram contadas" , boxFruitsInContact[type])
        -- print("quantidade de " .. type, boxFruitsInContact[type], scoreButton[index_Type[type]]['type'].label.number)

        scoreButton[index_Type[type]]['score'].label.number = scoreButton[index_Type[type]]['score'].label.number - 1    
        scoreButton[index_Type[type]]['score'].label.text:set(scoreButton[index_Type[type]]['score'].label.number)

        scoreButton[index_Type[type]]['score'].box.position.x = scoreButton[index_Type[type]]['score'].box.position.x + scoreButton[index_Type[type]]['score'].box.size.width - scoreButton[index_Type[type]]['score'].label.text:getWidth() - margens

        scoreButton[index_Type[type]]['score'].box.size.width = margens + scoreButton[index_Type[type]]['score'].label.text:getWidth()

        scoreButton[index_Type[type]]['score'].label.position.x = scoreButton[index_Type[type]]['score'].box.position.x + (math.abs(scoreButton[index_Type[type]]['score'].box.size.width - scoreButton[index_Type[type]]['score'].label.text:getWidth())/2)
    end    
end

function score.show()
    for i, _ in pairs(scoreButton) do
        love.graphics.setColor(0, 0, 0, 20)
        love.graphics.rectangle("fill", scoreButton[i]['score'].box.position.x - 2, scoreButton[i]['score'].box.position.y, scoreButton[i]['type'].box.size.width + scoreButton[i]['score'].box.size.width, scoreButton[i]['type'].box.size.height)


        love.graphics.setColor(0, 0, 0, 0)
        love.graphics.rectangle("fill", scoreButton[i]['type'].box.position.x + 1, scoreButton[i]['type'].box.position.y, scoreButton[i]['type'].box.size.width - 2, scoreButton[i]['type'].box.size.height)
        
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(scoreButton[i]['type'].image.icon, scoreButton[i]['type'].image.position.x, scoreButton[i]['type'].image.position.y)


        love.graphics.setColor(button.setColor("red"))
        love.graphics.rectangle("fill", scoreButton[i]['score'].box.position.x, scoreButton[i]['score'].box.position.y, scoreButton[i]['score'].box.size.width, scoreButton[i]['score'].box.size.height)

        love.graphics.setColor(button.setColor("black%20"))
        love.graphics.rectangle("fill", scoreButton[i]['type'].label.box.position.x - 2, scoreButton[i]['type'].label.box.position.y, scoreButton[i]['type'].label.box.size.width + 2, scoreButton[i]['type'].label.box.size.height + 2)


        love.graphics.setColor(button.setColor("white"))
        love.graphics.rectangle("fill", scoreButton[i]['type'].label.box.position.x, scoreButton[i]['type'].label.box.position.y, scoreButton[i]['type'].label.box.size.width, scoreButton[i]['type'].label.box.size.height)
      
        love.graphics.setColor(0, 0, 0, 20)
        love.graphics.draw(scoreButton[i]['score'].label.text,  scoreButton[i]['score'].label.position.x + 2, scoreButton[i]['score'].label.position.y + 2)

        -- Texto de Caixas que cairam no chão
        love.graphics.setColor(255, 255, 255, 240)
        love.graphics.draw(scoreButton[i]['score'].label.text,  scoreButton[i]['score'].label.position.x, scoreButton[i]['score'].label.position.y)

        love.graphics.setColor(0, 0, 0, 240)
        love.graphics.draw(scoreButton[i]['type'].label.text,  scoreButton[i]['type'].label.position.x, scoreButton[i]['type'].label.position.y)

    end
end

function score.findValue(value)
    for i, v in ipairs(typeFruits_availableForChoose) do
        if v == value then table.remove(typeFruits_availableForChoose, i) end
    end
end
life = {}
lifeList = {}

local function scale(indx, dly)
    local index = indx
    local delay = 0
    local a = true
    local b = true

    return function(dt)

        if delay <= 0 then 
            if b then
                if a then 
                    lifeList[index].scale.x = lifeList[index].scale.x + 0.2
                    lifeList[index].scale.y = lifeList[index].scale.y + 0.2
                end

                if lifeList[index].scale.x >= 1.4 or not a then
                    lifeList[index].scale.x = lifeList[index].scale.x - 0.2
                    lifeList[index].scale.y = lifeList[index].scale.y - 0.2

                    a = false

                    if lifeList[index].scale.x == 1 then
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

local cont = 1


function life.lost(point, x, y)

    --table.insert( lifeList, 
       lifeList['lost' .. cont]  = {
        ['text'] = love.graphics.newText(font.mullerNarrow.extraBold.size[30], tostring(point)),
        ['position'] = {
            ['x'] = x,
            ['y'] = y,
            },
        ['scale'] = {
            ['x'] = 0,
            ['y'] = 0,
            },
        ['func'] = scale('lost' .. cont, 0.07),

        }
    --)
    cont = cont + 1
end

function life.update(dt)
    for i, _ in pairs(lifeList) do
        if lifeList[i].func(dt) then --[[table.remove(lifeList, i)]] lifeList[i] = nil end
    end
end

function life.show()
    for i, _ in pairs(lifeList) do
        love.graphics.setColor(button.setColor("white"))
        love.graphics.draw(lifeList[i].text, lifeList[i].position.x, lifeList[i].position.y, 0, lifeList[i].scale.x, lifeList[i].scale.y, lifeList[i].text:getWidth()/2, lifeList[i].text:getHeight()/2)

        love.graphics.setColor(button.setColor("black%20"))
        love.graphics.draw(lifeList[i].text, lifeList[i].position.x + 2, lifeList[i].position.y + 2, 0, lifeList[i].scale.x, lifeList[i].scale.y, lifeList[i].text:getWidth()/2, lifeList[i].text:getHeight()/2)

    end

end
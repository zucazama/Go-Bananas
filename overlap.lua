overlap = {}
overlapList = {}

local function scale(indx, dly)
    local index = indx
    local delay = 0
    local a = true
    local b = true

    return function(dt)

        if delay <= 0 then 
            if b then
                if a then 
                    overlapList[index].scale.x = overlapList[index].scale.x + 0.2
                    overlapList[index].scale.y = overlapList[index].scale.y + 0.2
                end

                if overlapList[index].scale.x >= 1.4 or not a then
                    overlapList[index].scale.x = overlapList[index].scale.x - 0.2
                    overlapList[index].scale.y = overlapList[index].scale.y - 0.2

                    a = false

                    if overlapList[index].scale.x == 1 then
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


function overlap.lost(textOrImage, x, y, dly)

    --table.insert( overlapList, 
       overlapList['lost' .. cont]  = {
        ['text'] = type(textOrImage) == "string" and love.graphics.newText(font.mullerNarrow.extraBold.size['30'], tostring(point)) or textOrImage,
        ['position'] = {
            ['x'] = x,
            ['y'] = y,
            },
        ['scale'] = {
            ['x'] = 0,
            ['y'] = 0,
            },
        ['func'] = scale('lost' .. cont, dly or 0.07),

        }
    --)
    cont = cont + 1
end

function overlap.update(dt)
    for i, _ in pairs(overlapList) do
        if overlapList[i].func(dt) then --[[table.remove(overlapList, i)]] overlapList[i] = nil end
    end
end

function overlap.show()
    for i, _ in pairs(overlapList) do
        love.graphics.setColor(button.setColor("white"))
        love.graphics.draw(overlapList[i].text, overlapList[i].position.x, overlapList[i].position.y, 0, overlapList[i].scale.x, overlapList[i].scale.y, overlapList[i].text:getWidth()/2, overlapList[i].text:getHeight()/2)

        love.graphics.setColor(button.setColor("black%20"))
        love.graphics.draw(overlapList[i].text, overlapList[i].position.x + 2, overlapList[i].position.y + 2, 0, overlapList[i].scale.x, overlapList[i].scale.y, overlapList[i].text:getWidth()/2, overlapList[i].text:getHeight()/2)

    end

end
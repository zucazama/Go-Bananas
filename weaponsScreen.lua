weaponsScreen = {}
weaponsScreen_List = {}

function weaponsScreen.new(img, txt, defalt)

    local text = love.graphics.newText(font.mullerNarrow.light.size[15], txt)
    local positionImgX = #weaponsScreen_List > 0 and (weaponsScreen_List[#weaponsScreen_List].image.position.x + weaponsScreen_List[#weaponsScreen_List].image.icon:getWidth() + 20) or 40
    local positionImgY = _G.height - (40 + img:getHeight() + text:getHeight() + 20)
    local textX = positionImgX + (math.abs(img:getWidth() - text:getWidth())/2)
    local textY = positionImgY + img:getHeight() + 10

    -- weaponsScreen_List[guy] = {
        table.insert(weaponsScreen_List, {
        ['label'] = {
            ['text'] = text,
            ['position'] = {
                ['x'] = textX,
                ['y'] = textY,
            },
        },
        ['rectangle'] = {
            ['position'] = {
                ['x'] = positionImgX,
                ['y'] = positionImgY + img:getHeight(),
            },
            ['size'] = {
                ['width'] = img:getWidth(),
                ['height'] = text:getHeight() + 20,
            },
        },
        ['image'] = {
            ['icon'] = img,
            ['position'] = {
                ['x'] = positionImgX,
                ['y'] = positionImgY,
            },
        },
        ['select'] = defalt,
    }
        )

end


function weaponsScreen.show()
    for i, _ in pairs(weaponsScreen_List) do

        -- love.graphics.setBlendMode("subtract")
        love.graphics.setColor(255, 255, 255, weaponsScreen_List[i].select and 255 or 200)
        love.graphics.draw(weaponsScreen_List[i].image.icon, weaponsScreen_List[i].image.position.x, weaponsScreen_List[i].image.position.y)
        print(weaponsScreen_List[i].image.position.y)
        love.graphics.setBlendMode("alpha")

        love.graphics.setColor(button.setColor("black%20"))
        love.graphics.rectangle("fill", weaponsScreen_List[i].rectangle.position.x, weaponsScreen_List[i].rectangle.position.y, weaponsScreen_List[i].rectangle.size.width, weaponsScreen_List[i].rectangle.size.height)

        love.graphics.setColor(button.setColor("white"))
        love.graphics.rectangle("fill", weaponsScreen_List[i].rectangle.position.x + 2, weaponsScreen_List[i].rectangle.position.y + 2, weaponsScreen_List[i].rectangle.size.width - 4, weaponsScreen_List[i].rectangle.size.height - 4)

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.draw(weaponsScreen_List[i].label.text, weaponsScreen_List[i].label.position.x, weaponsScreen_List[i].label.position.y, 0, 1, 1)
   
        if weaponsScreen_List[i].select then
            love.graphics.setColor(0, 0, 0, 200)
            love.graphics.rectangle("line", weaponsScreen_List[i].image.position.x, weaponsScreen_List[i].image.position.y, weaponsScreen_List[i].image.icon:getWidth() ,weaponsScreen_List[i].image.icon:getHeight())
        end
    end

end
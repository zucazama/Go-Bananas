button = {}
button.__index = button

buttons = setmetatable({}, button)
buttonsOnClickEx = {}
--    {
--        title = love.graphics.newText(font, 'Iníciar'),
--        position = {x = 20, y = 20}
       
--     }

-- corSelecionada = 'defalt'

function button:setColor(name)
    local color = {
        defalt = {255, 255, 255, 70},
        select = {0, 0, 0, 70},
		click = {0, 0 , 255, 50}
    }

    return color[name][1], color[name][2], color[name][3], color[name][4] or 255
end

function button:getColor()
    return self.color[1], self.color[2], self.color[3], self.color[4] or 255  
end

    margens = 20



function button:new(text, align, func, color)

    
        -- self.title = love.graphics.newText(font, text),
        -- self.position.x = margens,
        -- self.position.y = (margens + self.title:getWidth() + 40),
        -- self.rectangle.position.x = math.abs(self.position.x - (margens/2)),
        -- self.rectangle.position.y = math.abs(self.position.y - (margens/2)),
        -- self.rectangle.size.width = self.title:getWidth() + margens,
        -- self.rectangle.size.height = self.title:getHeight() + margens,
        -- self.action = func
        
    for i = 1, #buttons do
        
    end
 
        local title = love.graphics.newText(font.mullerNarrow.extraBold.size['30'], text)

        local position = {
            x,
            y = title:getHeight() + margens + (70 * (2 + #buttons))
        }

		if align == 'left' then 
            position.x = width/14 
        elseif align == 'center' then 
            position.x = width/2 - title:getWidth()/2 
        elseif align == 'right' then 
            position.x = width - (width/14) - title:getWidth() 
        end
        
        local rectangle = { 
            position = {
                x = math.abs(position.x - (margens/2)),
                y = math.abs(position.y - (margens/2))
            },
            size = {
                width = title:getWidth() + margens,
                height = title:getHeight() + margens
            }
        }

        local action = func


    table.insert(buttons, setmetatable(
        {
        ['label'] = text,
        ['title'] = title,
        ['align'] = align,
        ['position'] = position,
        ['rectangle'] = rectangle,
        ['action'] = action,
        ['color'] = {button:setColor(color or 'defalt')}
        }, button))

end

function button:update()
    for i, _ in pairs(buttons) do
    
	    if buttons[i].align == 'left' then 
            buttons[i]['position'].x = _G.width/14 
        elseif buttons[i].align == 'center' then 
            buttons[i]['position'].x = _G.width/2 - buttons[i]['title']:getWidth()/2 
        elseif buttons[i].align == 'right' then 
            buttons[i]['position'].x = _G.width - (_G.width/14) - buttons[i].title:getWidth() 
        end

        buttons[i].rectangle.position.x = buttons[i]['position'].x - margens/2
    end
end

function button:setFont(index, sizeFont, nameFont)
        self['title']:setFont(font.mullerNarrow.extraBold.size[sizeFont])

        self['rectangle'].size.width = self['title']:getWidth() + margens
        self['rectangle'].size.height = self['title']:getHeight() + margens
        -- while (buttons[1].rectangle.position.x + buttons[1].rectangle.size.width) > 0 do
            for i = (index + 1), #buttons do
                 -- self.position.x = margens
                
                buttons[i]['position'].y = buttons[(i - 1) > 0 and (i - 1) or i]['title']:getHeight() + margens + (20 + buttons[(i - 1) > 0 and (i - 1) or i].position.y)
                -- self.rectangle.position.x = math.abs(self.position.x - (margens/2))
                buttons[i]['rectangle'].position.y = math.abs(buttons[i]['position'].y - (margens/2))
                -- buttons[i].position.x = buttons[i].position.x - 1
                -- buttons[i].rectangle.position.x = buttons[i].rectangle.position.x - 1
            end
        -- end

end

function button:show()
    -- love.graphics.print(tostring(buttons[1].position.x), 10, 25)
    --love.graphics.draw(buttons[1].title, 50, 50)
    for i, _ in pairs(buttons) do
        if buttons[i].title then
            -- love.graphics.setColor(255, 255, 255, 50)
            -- love.graphics.rectangle('fill', self.rectangle.position.x, self.rectangle.position.y, self.rectangle.size.width, self.rectangle.size.height)
            
            -- love.graphics.setColor(255, 255, 255)
            -- love.graphics.draw(self.title, self.position.x, self.position.y)
            -- love.graphics.print(tostring(buttons[i].color[2]), buttons[i].rectangle.position.x - 30, buttons[i].rectangle.position.y)

            love.graphics.setColor(buttons[i].color[1], buttons[i].color[2], buttons[i].color[3], buttons[i].color[4] or 255)
            love.graphics.rectangle('fill', buttons[i].rectangle.position.x, buttons[i].rectangle.position.y, buttons[i].rectangle.size.width, buttons[i].rectangle.size.height)
            
            love.graphics.setColor(255, 255, 255)
            love.graphics.draw(buttons[i].title, buttons[i].position.x, buttons[i].position.y)
        end
    end
end


function button:houver(x, y)
    local buttonSelect

    for i, _ in pairs(buttons) do
        if buttons[i].title then
            if x > buttons[i].rectangle.position.x and x < (buttons[i].rectangle.position.x + buttons[i].rectangle.size.width) and y > buttons[i].rectangle.position.y and y < (buttons[i].rectangle.position.y + buttons[i].rectangle.size.height) then
                --font = love.graphics.setNewFont(50)
                buttons[i].color = {button:setColor('select')}
                buttonSelect = i
                if (buttons[i].title:getFont()):getHeight() ~= 40 then buttons[i]:setFont(i, '40', 'mullerNarrow.extraBold') end
                -- buttons[i].title:setFont(font.saf.size['40'])
                
            else
                -- love.graphics.setBackgroundColor(255, 255, 100)
                if (buttons[i].title:getFont()):getHeight() ~= 30 then buttons[i]:setFont(i, '30', 'mullerNarrow.extraBold') end
                buttons[i].color = {button:setColor('defalt')}
            end

        end
    end
end

function button:onClickEx()
    local x = self.rectangle.position.x
    local y = self.rectangle.position.y

    local width = self.rectangle.size.width
    local height = self.rectangle.size.height

    local controller = 1

    return function()
        
        if controller == 30 then return false end

        love.graphics.setColor(255, 255, 255, 150)
        love.graphics.rectangle('line', x, y, width, height)
 
        x = x - 1
        y = y - 1

        width = width + 2
        height = height + 2

        controller = controller + 1
        
    end
end

function button:onClick(x, y, key)
    if key == 1 then
        for i, _ in ipairs(buttons) do
            if buttons[i].title then
                if x > buttons[i].rectangle.position.x and x < (buttons[i].rectangle.position.x + buttons[i].rectangle.size.width) and y > buttons[i].rectangle.position.y and y < (buttons[i].rectangle.position.y + buttons[i].rectangle.size.height) then
                    print(buttons[i].label)
                    table.insert(buttonsOnClickEx, buttons[i]:onClickEx())
                    -- table.remove( buttons, [] )
                    -- buttons[i]:update(i, '40')
                    -- buttons[i].color = {button:setColor('click')}
                    buttons[i].action()
                    -- button:update()


                end
            end
        end
    end

end

--return buttons

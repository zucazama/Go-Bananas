button = {}
button.__index = button

userBar = {}
userBar.__index = userBar
userBarBotton = setmetatable({}, userBar)

buttons = setmetatable({}, button)

buttonsOnClickEx = {}

local margens = 40



function button.setColor(name)
    local color = {
        ['defalt'] = {255, 82, 0, 240},
        ['orange'] = {255, 170, 0, 240},
        ['roxo'] = {180, 3, 100, 240},
        ['red'] = {255, 20, 0, 240},
        ['blue'] = {0, 120, 255, 240},
        ['white'] = {255, 255, 255, 240},
        ['green'] = {113, 255, 0, 240},
        ['black%20'] = {0, 0, 0, 20},
        ['white%20'] = {255, 255, 255, 20},
        ['select'] = {255, 140, 0, 255},
		['click'] = {255, 0 , 0, 125}
    }

    return color[name][1], color[name][2], color[name][3], color[name][4] or 255
end

function button:getColor()
    return self.color[1], self.color[2], self.color[3], self.color[4] or 255  
end


function button:new(text, align, func, color, icon, isLocked)

    
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
            x = #self ~= 0 and self[#self].rectangle.position.x + self[#self].rectangle.size.width + margens/2 or 60,
            y = _G.height/2 - 100
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
        ['align'] = align,
        ['position'] = position,
        ['rectangle'] = rectangle,
        ['action'] = func,
        ['color'] = {['defalt'] = color or 'defalt', ['select'] = 'select'},
        ['select'] = false,
        ['isLocked'] = isLocked or false,
        ['escale'] = {['x'] = 1, ['y'] = 1},

        }, button))

end

function button:update()
end

function button:setFont(index, sizeFont, ...)
    self.title:setFont(font.mullerNarrow.extraBold.size[tostring(sizeFont)])
end

function userBar:new(text, icon, mx, my, color, action)
    -- Fica no rodapé da tela

    if icon then
        image = { ['image'] = icon}
        -- local label = { ['text'] = love.graphics.newText(font.mullerNarrow.light.size['15'], text or "")}

        box = {
            ['position'] = {
                ['x'] = #self > 0 and (self[#self].box.position.x + self[#self].box.size.width) or 40,
                ['y'] = 60
            }
        }
        -- print(box.position.x)
        image.position = {
            ['x'] = box.position.x + margens/2,
            ['y'] = box.position.y + (math.abs(40 - image.image:getHeight())/2),

        }

        label = nil
        -- label.position = {
        --     ['x'] = image.position.x + margens/2,
        --     ['y'] = image.position.y + math.abs(image.image:getHeight() - label.text:getHeight())/2,
        -- }

            box['size'] = {
                ['width'] = margens + image.image:getWidth(),
                ['height'] = 40,
            }
    
    elseif text then 
        image = nil
        label = { ['text'] = love.graphics.newText(font.mullerNarrow.light.size['15'], text)}


        box = {
            ['position'] = {
                ['x'] = #self > 0 and self[#self].box.position.x + self[#self].box.size.width or 40,
                ['y'] = 60
            },
            ['size'] = {
                ['width'] = margens + label.text:getWidth(),
                ['height'] = 40,
            }
        }

        label.position = {
            ['x'] = box.position.x + margens/2,
            ['y'] = box.position.y + (math.abs(box.size.height - label.text:getHeight())/2),
        }
    end

    table.insert(self, {
        ['label'] = label,
        ['icon'] = image,
        ['box'] = box,
        ['select'] = false,
        ['action'] = action,
        ['color'] = {
            ['defalt'] = color or "white%20",
            ['select'] = {},
        }
        -- ['position'] = position,
    })

        -- print(table.unpack({2, 4, 5, 5, 6}))
end 

function userBar:show()
    for i, v in ipairs(self) do
        
        love.graphics.setColor(0, 0, 0, 30)
        love.graphics.rectangle("fill", self[i].box.position.x, self[i].box.position.y, self[i].box.size.width, self[i].box.size.height)

        
        love.graphics.setColor(button.setColor(self[i].color.defalt))
        love.graphics.rectangle("fill", self[i].box.position.x + 1, self[i].box.position.y, self[i].box.size.width - 2, self[i].box.size.height)
        
        if self[i].icon then
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(self[i].icon.image, self[i].icon.position.x, self[i].icon.position.y)
        end

        if self[i].label then
            love.graphics.setColor(0, 0, 0, 255)
            love.graphics.draw(self[i].label.text,  self[i].label.position.x, self[i].label.position.y)
        end

        if self[i].select then
            love.graphics.setColor(0, 0, 0, 200)
            love.graphics.rectangle("line", self[i].box.position.x, self[i].box.position.y, self[i].box.size.width, self[i].box.size.height)
        end
    end
end

function button:show()
    -- love.graphics.print(tostring(buttons[1].position.x), 10, 25)
    --love.graphics.draw(buttons[1].title, 50, 50)
    for i, _ in pairs(self) do
        if buttons[i].title then
            -- love.graphics.setColor(255, 255, 255, 50)
            -- love.graphics.rectangle('fill', self.rectangle.position.x, self.rectangle.position.y, self.rectangle.size.width, self.rectangle.size.height)
            
            -- love.graphics.setColor(255, 255, 255)
            -- love.graphics.draw(self.title, self.position.x, self.position.y)
            -- love.graphics.print(tostring(buttons[i].color[2]), buttons[i].rectangle.position.x - 30, buttons[i].rectangle.position.y)
        --    love.graphics.polygon('fill', 50, 50, 100, 50, 75, 100)
            
            -- Sombra
            love.graphics.setColor(0, 0, 0, 10)
            love.graphics.rectangle('fill', self[i].rectangle.position.x - 2, self[i].rectangle.position.y - 2, self[i].rectangle.size.width + 4, self[i].rectangle.size.height + 4)

            love.graphics.setColor(0, 0, 0, 40)
            love.graphics.rectangle('fill', self[i].rectangle.position.x, self[i].rectangle.position.y, self[i].rectangle.size.width, self[i].rectangle.size.height)
            
            love.graphics.setColor(button.setColor(self[i].color.defalt))
            love.graphics.rectangle("fill", self[i].rectangle.position.x, self[i].rectangle.position.y, self[i].rectangle.size.width, self[i].title:getHeight() + margens/2)

            love.graphics.setColor(255, 255, 255, 200)
            love.graphics.draw(self[i].image.icon, self[i].image.position.x, self[i].image.position.y)

            love.graphics.setColor(0, 0, 0, 40)
            love.graphics.draw(self[i].title, self[i].position.x + 2, self[i].position.y + 2, 0, 1, 1, self[i].title:getWidth()/2, self[i].title:getHeight()/2)

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

            if buttons[i].select then
                love.graphics.setColor(0, 0, 0, 200)
                love.graphics.rectangle('line', self[i].rectangle.position.x, self[i].rectangle.position.y, self[i].rectangle.size.width, self[i].rectangle.size.height)
            end
        end
    end
end


function button:houver(x, y)
    local buttonSelect

    for i, _ in pairs(buttons) do
        if buttons[i].title then
            if x > buttons[i].rectangle.position.x and x < (buttons[i].rectangle.position.x + buttons[i].rectangle.size.width) and y > buttons[i].rectangle.position.y and y < (buttons[i].rectangle.position.y + buttons[i].rectangle.size.height) then
                --font = love.graphics.setNewFont(50)
                -- buttons[i].color = {button.setColor('select')}
                buttons[i].select = true
                buttonSelect = i
                if (buttons[i].title:getFont()):getHeight() ~= 40 then buttons[i]:setFont(i, 40, 'mullerNarrow', 'extraBold') end
                -- buttons[i].title:setFont(font.saf.size['40'])
                
            else
            buttons[i].select = false
                -- love.graphics.setBackgroundColor(255, 255, 100)
                if (buttons[i].title:getFont()):getHeight() ~= 30 then buttons[i]:setFont(i, 30, 'mullerNarrow', 'extraBold') end
                -- buttons[i].color = {button.setColor('defalt')}
            end

        end
    end
end

function userBar:houver(x, y)
    for i, _ in ipairs(self) do
        if x > self[i].box.position.x and x < (self[i].box.position.x + self[i].box.size.width) and y > self[i].box.position.y and y < (self[i].box.position.y + self[i].box.size.height) then
            self[i].select = true
        else
            self[i].select = false
        end
    end
end

function userBar:onClick(x, y)
    for i, _ in ipairs(self) do
        if x > self[i].box.position.x and x < (self[i].box.position.x + self[i].box.size.width) and y > self[i].box.position.y and y < (self[i].box.position.y + self[i].box.size.height) then
            self[i].action()
        else
        end
    end
end

function button:onClickEx()
--[[
    local func = self.action

    local x = self.rectangle.position.x
    local y = self.rectangle.position.y

    local width = self.rectangle.size.width
    local height = self.rectangle.size.height

    local controller = 1

    return function()
        
        if controller == 30 then func() return false end

        love.graphics.setColor(button.setColor('select'))
        love.graphics.rectangle('line', x, y, width, height)
 
        x = x - 1
        y = y - 1

        width = width + 2
        height = height + 2

        controller = controller + 1
        
    end
--]]
end

function button:onClick(x, y, key)
    if key == 1 then
        for i, _ in ipairs(buttons) do
            if buttons[i].title then
                if x > buttons[i].rectangle.position.x and x < (buttons[i].rectangle.position.x + buttons[i].rectangle.size.width) and y > buttons[i].rectangle.position.y and y < (buttons[i].rectangle.position.y + buttons[i].rectangle.size.height) then
                    -- print(buttons[i].label)
                    buttons[i].action()
                    -- table.insert(buttonsOnClickEx, buttons[i]:onClickEx())
                    -- table.remove( buttons, [] )
                    -- buttons[i]:update(i, '40')
                    -- buttons[i].color = {button.setColor('click')}
                    -- buttons[i].action()
                    -- button:update()
                end
            end
        end
    end
end

--return buttons

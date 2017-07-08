gap = {}

gap.__index = gap


ca = setmetatable({}, gap)
text1 = setmetatable({}, gap)


local x, y = _G.width/2, _G.height/2

local controller = 1

function gap:new(text, x, y)
    -- local comprimento = love.graphics.newText(font.mullerNarrow.extraBold.size[40], s):getWidth()/#s

    for caracter, space in string.gmatch(text, '.' ) do
        local label = love.graphics.newText(font.mullerNarrow.extraBold.size[40], caracter) 

        table.insert(self, {
            ['label'] = label, 
            ['position'] = {['x'] = x, ['y'] = y},
            ['escale'] = { ['x'] = 0, ['y'] = 0}
            })
--[[            function () 
                letter = caracter

                love.graphics.print(letter, x, y)
                -- love.graphics.print(tostring(x), 10, 10)
            
                -- if controller and y > 10 then
                --     -- x = x - 1
                --     y = y - 1
            
                -- else
                --     -- x = x + 1
                --     y = y + 1

                --     controller = controller == 20 and true or false

                --  end
            end
]]        
    end

    for i, _ in ipairs(self) do
        
        -- self[i].position.x = i == 1 and x or x + self[i].label:getWidth()
        self[i].position.x = x
        x = x + self[i].label:getWidth()
    end

end

local delay = 0.02
local a = false
local b = false
local index = 1


function gap:update(dt)
    if delay <= 0 and index <= #ca  then 
        if b then
            -- self[index].label:setFont(font.mullerNarrow.lightItalic.size[50])
            if a then 
                self[index].escale.x = self[index].escale.x + 0.2
                self[index].escale.y = self[index].escale.y + 0.2
            end

            if self[index].escale.x >= 1.4 or not a then
                self[index].escale.x = self[index].escale.x - 0.2
                self[index].escale.y = self[index].escale.y - 0.2

                a = false

                if self[index].escale.x == 1 then
                    index = index + 1
                    a = true
                end
            end
        else
        
            whatIsVisible.gap = false; whatIsVisible.openSreen = true    
        end

        delay = 0.02

        if index > #ca then index = #ca; delay = 1 --[[whatIsVisible.gap = false; whatIsVisible.menu = true]] b = false end
        -- index = index + 1
    end


    delay = delay - dt
--]]

end
function gap:show()
---[[
    
    -- return false;
    -- love.graphics.draw(love.graphics.newText(font.mullerNarrow.extraBold.size[40], 'eat a fruit'), 20, 60)
    for i = 1, index do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self[i].label, self[i].position.x, self[i].position.y, 0, self[i].escale.x, self[i].escale.y, self[i].label:getWidth()/2, self[i].label:getHeight()/2)        
    end

end
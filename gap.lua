gap = {}

gap.__index = gap


ca = setmetatable({}, gap)


local controller = 1

function gap:new(text, x, y)
    -- local comprimento = love.graphics.newText(font.mullerNarrow.extraBold.size['40'], s):getWidth()/#s
    dummy = love.graphics.newText(font.mullerNarrow.extraBold.size['70'], text) 
    x = (_G.width/2 - dummy:getWidth()/2)

    for caracter, space in string.gmatch(text, '.' ) do
        local label = love.graphics.newText(font.mullerNarrow.extraBold.size['70'], caracter) 

        table.insert(self, {
            ['label'] = label, 
            ['position'] = {['x'] = nil, ['y'] = y},
            ['escale'] = { ['x'] = 0, ['y'] = 0}
            })       
    end

    for i, _ in ipairs(self) do        
        self[i].position.x = x
        x = x + self[i].label:getWidth()
    end

end

local delay = 0.02
local a = true
local b = true
local index = 1


function gap:update(dt)
    -- particle:update(dt)
    if delay <= 0 and index <= #ca  then 
        if b then
            -- self[index].label:setFont(font.mullerNarrow.lightItalic.size['50'])
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
            whatIsVisible.menu = true
            whatIsVisible.openScreen = true    
        end

        delay = 0.02

        if index > #ca then index = #ca; delay = 3 --[[whatIsVisible.gap = false; whatIsVisible.menu = true]] b = false end
        -- index = index + 1
    end


    delay = delay - dt
--]]

end
function gap:show()
---[[
    
    -- return false;
    -- love.graphics.draw(love.graphics.newText(font.mullerNarrow.extraBold.size['40'], 'eat a fruit'), 20, 60)
    for i = 1, index do
        -- love.graphics.draw(particle, self[i].position.x + (self[i].label:getWidth()/2), self[i].position.y --[[+ (self[i].label:getHeight()/2)]])
        love.graphics.setColor(0, 0, 0, 40)

        love.graphics.draw(self[i].label, self[i].position.x + 4, self[i].position.y + 4, 0, self[i].escale.x, self[i].escale.y, self[i].label:getWidth()/2, self[i].label:getHeight()/2)        
        
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self[i].label, self[i].position.x, self[i].position.y, 0, self[i].escale.x, self[i].escale.y, self[i].label:getWidth()/2, self[i].label:getHeight()/2)        
    
    end

end

-- http://conky.wikia.com/wiki/More_detailed_Lua_example
do

local pre = '${offset 40}'
local width = 75

local state = ''
local text = "Hello there! I'm Makise Kurisu, nice to meet you!"
local buffer = pre
local tick = 0
local updated = false

local eyes = 'happy'
local mouth = 'happy'

--http://lua-users.org/wiki/StringRecipes
function wrap(str, limit)
local here = 1
  return str:gsub("(%s+)()(%S+)()",
                          function(sp, st, word, fi)
                            if fi-here > limit then
                              here = st
                              return "\n"..word
                            end
                          end)
end

function update_text()

local file = io.open('input.txt', 'rb')
local new_state = file:read('*l')
if new_state == state then 
file:close()
return
end
state = new_state
file:close()

if state == 'hello' then
text = "Hello there! I'm Makise Kurisu, nice to meet you!"
updated = true
--elseif state == 'goodbye' then
elseif state == 'goodbye' then
text='Goodbye!'
updated = true
end

if updated then
text = wrap(text, width)
buffer = pre
tick = 0
updated = false
end
--tick = 0

end

function conky_string_func()
update_text()
tick = tick + 1
if text:sub(tick, tick) == '\n' then
buffer = buffer .. '\n' .. pre
else
buffer = buffer .. text:sub(tick, tick)
end
return buffer
end

function conky_image_func()
return '${image ./eyes/' .. eyes .. '.png -p 930,192 -s 569x128}' ..
'${image ./mouth/' .. mouth .. '.png -p 933,425 -s 569x65}'
end

end

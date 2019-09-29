lg = love.graphics
lm = love.math
lw = love.window
lk = love.keyboard
le = love.event

ti = require 'timer'
gs = require 'gamestate'
a8 = require 'anim8'
rpl = require 'ripple'
sti = require 'sti'
class = require 'middleclass'
states = {}
states.game = require 'game'

-- utils
function down() 
  return lk.isDown('down')
end

function up() 
  return lk.isDown('up')
end

function left() 
  return lk.isDown('left')
end

function right() 
  return lk.isDown('right')
end

function adown() 
  return lk.isDown('s')
end

function aup() 
  return lk.isDown('w')
end

function aleft() 
  return lk.isDown('a')
end

function aright() 
  return lk.isDown('d')
end


function add(tbl, val)
  table.insert(tbl, val)
end

function foreach(tbl, f)
  for k,v in pairs(tbl) do
    f(v)
  end
end

function del(tbl, ind)
  table.remove(tbl, ind)
end

function clamp(lo, val, hi)
  return math.max(math.min(val, hi), lo)
end

-- game start
function love.load()
  desk_w = lg.getWidth()
  desk_h = lg.getHeight()

  gs.registerEvents()
  gs.switch(states.game)
end

function love.update(dt)

end

function love.draw()
  
end

function love.keypressed(k)
  if k == 'escape' then
    le.quit()
  elseif k == 'r' then
    le.quit('restart')
  end
end
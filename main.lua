lg = love.graphics
lm = love.math
lw = love.window
lk = love.keyboard
le = love.event

setmetatable(_G, {
  __index = require('cargo').init('/')
})
ti = require 'timer'
gs = require 'gamestate'
rpl = require 'ripple'
sti = require 'sti'
class = require 'middleclass'
states = {}
states.game = require 'game'
states.score = require 'score_screen'

Subject = require 'Subject'
VisibleSubject = require 'VisibleSubject'
MovingSubject = require 'MovingSubject'

fonts = {
  [14] = fonts.PICO(14)
}

sfx = {
  shutter = rpl.newSound(sounds.shutter),
  whir = rpl.newSound(sounds.whir),
  beep = rpl.newSound(sounds.beep),
}

-- utils
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
  lg.setFont(fonts[14])

  gs.registerEvents()
  gs.switch(states.game, {lvl_num = 1})
end

function love.update(dt)
  ti.update(dt)
end



function love.keypressed(k)
  if k == 'escape' then
    le.quit()
  elseif k == 'r' then
    le.quit('restart')
  end
end
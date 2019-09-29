local state = {}

local cam = {
  spd = 10,
  grow_spd = 5,
  base_w = 200,
  base_h = 200,
  w = 200,
  h = 200,
}

local game_w, game_h = 900, 700
local margin_x, margin_y = 0,0

local function move_cam()
  local x,y = lw.getPosition()
  local dx,dy = 0,0

  if up() then dy = dy - 1 end
  if down() then dy = dy + 1 end
  if left() then dx = dx - 1 end
  if right() then dx = dx + 1 end

  x = clamp(margin_x, x + cam.spd * dx, desk_w - cam.w - margin_x)
  y = clamp(margin_y, y + cam.spd * dy, desk_h - cam.h - margin_y)
  
  lw.setPosition(x,y)
end

local function change_w(dw)
  if dw > 0 then
    cam.w = clamp(0, cam.w + dw * cam.grow_spd, desk_w - cam.w - margin_x)
  else

  end


  lw.setMode(cam.w, cam.h)
  local x,y = lw.getPosition()
  lw.setPosition(x,y)
end

local function change_dims()
  local dw,dh = 0,0

  if aup() then dh = dh - 1 end
  if adown() then dh = dh + 1 end
  if aleft() then dw = dw - 1 end
  if aright() then dw = dw + 1 end

  if dw ~= 0 then change_w(dw) end
end


local function reset()
  margin_x, margin_y = (desk_w - game_w) / 2, (desk_h - game_h) / 2
  lw.setMode(cam.base_w, cam.base_h)
  lw.setPosition((desk_w - cam.base_w) / 2, (desk_h - cam.base_h) / 2)
end

function state:enter()
  reset()
end

function state:update(dt)
  move_cam()
  change_dims()
end

function state:draw()

end

function state:keypressed()

end

return state
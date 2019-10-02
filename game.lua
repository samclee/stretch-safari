local state = {}

local cam = {}
local subjects, shutter = {}, {}
local cur_num, goal_num, score = 0,0,0
local game_w, game_h = 900, 700
local margin_x, margin_y = 0,0
local bg = nil

local function move_cam()
  local x,y = lw.getPosition()
  local dx,dy = 0,0

  if lk.isDown('up') then dy = dy - 1 end
  if lk.isDown('down') then dy = dy + 1 end
  if lk.isDown('left') then dx = dx - 1 end
  if lk.isDown('right') then dx = dx + 1 end

  x = clamp(margin_x, x + cam.spd * dx, desk_w - cam.w - margin_x)
  y = clamp(margin_y, y + cam.spd * dy, desk_h - cam.h - margin_y)
  
  return x,y
end

local function change_w(dw, cur_x)
  if (dw > 0 and cam.ex > 0 and cur_x + cam.w < desk_w - margin_x) or (dw < 0 and cam.w > cam.base_w) then
    if cam.w == cam.base_w then sfx.whir:play() end
    cam.w = clamp(cam.base_w, cam.w + dw * cam.grow_spd, game_w)
    cam.ex = cam.ex - dw * cam.grow_spd
  end
end

local function change_h(dh, cur_y)
  if (dh > 0 and cam.ex > 0 and cur_y + cam.h < desk_h - margin_y) or (dh < 0 and cam.h > cam.base_h) then
    if cam.h == cam.base_h then sfx.whir:play() end  
    cam.h = clamp(cam.base_h, cam.h + dh * cam.grow_spd, game_h)
    cam.ex = cam.ex - dh * cam.grow_spd
  end
end

local function change_dims()
  local dw,dh = 0,0

  if lk.isDown('w') then dh = dh - 1 end
  if lk.isDown('s') then dh = dh + 1 end
  if lk.isDown('a') then dw = dw - 1 end
  if lk.isDown('d') then dw = dw + 1 end

  local x,y = lw.getPosition()
  change_w(dw, x)
  change_h(dh, y)

  if dw ~= 0 or dh ~= 0 then
    lw.setMode(cam.w, cam.h)
  end
end

local function get_game_pos()
  local x, y = lw.getPosition()
  return x - margin_x, y - margin_y
end

local function get_cam_box()
  local b = {}
  b.x, b.y = get_game_pos()
  b.y = b.y + 30
  b.w, b.h = cam.w, cam.h - 60

  return b
end

local function contains(b1, b2) --b1 contains b2
  return b1.x <= b2.x and b1.x + b1.w >= b2.x + b2.w and b1.y <= b2.y and b1.y + b1.h >= b2.y + b2.h
end

local function overlap(b1, b2)
  return b1.x < b2.x + b2.w and b2.x < b1.x + b1.w and b1.y < b2.y + b2.h and b2.y < b1.y + b1.h
end

local function get_interaction(cam_box, subj)
  if contains(cam_box, subj) then
    return 'contains'
  elseif overlap(cam_box, subj) then
    return 'overlaps'
  end

  return 'none'
end

local function load_map(name)
  local map = sti('maps/' .. name .. '.lua')
  cur_num = 0
  
  local new_goal = 0


  for k, obj in pairs(map.objects) do
    new_goal = new_goal + 1
    if obj.type == 'Subject' then
      table.insert(subjects, Subject:new({
                        id = obj.name,
                        x = obj.x, y = obj.y, w = obj.width, h = obj.height,
                      }))
    elseif obj.type == 'VisibleSubject' then
      io.write('Current table: [')
      for i,v in ipairs(subjects) do io.write(v.id .. ', ') end 
      io.write(']\n')
      
      table.insert(subjects, VisibleSubject:new({
                        id = obj.name,
                        x = obj.x, y = obj.y, w = obj.width, h = obj.height,
                        notice_spr = obj.properties.notice_spr,
                        idle_spr = obj.properties.idle_spr
                      }))
      
                      io.write('After creation: [')
      for i,v in ipairs(subjects) do io.write(v.id .. ', ') end 
      io.write(']\n\n')
    end
  end


  goal_num = new_goal
end

function state:reset(lvl_num)
  self.lvl_num = lvl_num
  local lvl_name = 'lvl' .. lvl_num
  cam = {
    spd = 5,
    grow_spd = 10,
    base_w = 240,
    base_h = 240,
    w = 0,
    h = 0,
    base_ex = 250,
    ex = 250,
    focused = false
  }
  shutter = {
    btm = {x = 0, y = 0, w = 0, h = 0},
    top = {x = 0, y = 0, w = 0, h = 0},
    active = false
  }
  cam.w,cam.h,cam.ex = cam.base_w, cam.base_h,cam.base_ex
  margin_x, margin_y = (desk_w - game_w) / 2, (desk_h - game_h) / 2
  lw.setMode(cam.base_w, cam.base_h)
  lw.setPosition((desk_w - cam.base_w) / 2, (desk_h - cam.base_h) / 2)
  bg = bgs[lvl_name]
  subjects = {}
  score = 0

  load_map(lvl_name)
end

function state:enter(from, opts)
  self:reset(opts.lvl_num)
end

function state:resume(from, opts)
  self:reset(opts.lvl_num)
end

function state:update(dt)
  local x,y = move_cam()
  change_dims()
  lw.setPosition(x,y)
  local cam_box = get_cam_box()
  cam.focused = false
  foreach(subjects, function(subj)
    local i = get_interaction(cam_box, subj)
    if subj.active and i == 'contains' then cam.focused = true end
    --subj:update(i)
  end)

end

function state:draw()
  local x,y = lw.getPosition()
  local off_x, off_y = x - margin_x, y - margin_y
  
  lg.push()
  lg.translate(-off_x, -off_y)
    lg.draw(bg, 0, 0)
    foreach(subjects, function(subj)
      --subj:draw()
    end)
  lg.pop()

  -- bar
  lg.setColor(0,0,0)
  lg.rectangle('fill',0,0,cam.w,30)
  lg.rectangle('fill',0,cam.h - 30,cam.w,30)

  -- shutter
  if shutter.active then
    local btm = shutter.btm
    lg.rectangle('fill', btm.x, btm.y, btm.w, btm.h)
    local top = shutter.top
    lg.rectangle('fill', top.x, top.y, top.w, top.h)
  end


  lg.setColor(0,1,0)
  lg.print('[          ]',10, 8)
  local bar_w = (cam.ex / cam.base_ex) * 110
  lg.rectangle('fill', 20, 8, bar_w, 14)
  
  local w_clr = {1,1,1}
  if cam.w > cam.base_w then w_clr = {0,1,0} end
  local h_clr = {1,1,1}
  if cam.h > cam.base_h then h_clr = {0,1,0} end

  lg.setColor(w_clr)
  lg.print(cam.w - 140, 153, 8)
  lg.setColor(h_clr)
  lg.print(cam.h - 140, 203, 8)


  lg.setColor(1,1,1)
  lg.print(cur_num .. '/' .. goal_num, cam.w - 40, cam.h - 21)
  lg.print('x', 189, 8)
  if cam.focused then lg.print('<space bar>', 10, cam.h - 21) end
end

function state:keypressed(k)
  if k == 'space' then
    foreach(subjects, function(subj)
      if subj.active and subj.view_state == 'contains' then
        score = score + subj:sleep()
        cur_num = cur_num + 1
        -- play shutter sound
        sfx.shutter:play()
        -- set shutter stats and positions
        shutter.btm = {x = 0, y = -cam.h / 2, w = cam.w, h = cam.h / 2}
        shutter.top = {x = 0, y = cam.h, w = cam.w, h = cam.h / 2}
        -- start tweens
        ti.tween(.1, shutter.btm, {y = 0}, 'linear', function() shutter.active = false end)
        ti.tween(.1, shutter.top, {y = cam.h / 2})
        --set active
        shutter.active = true
      end
    end)

    if cur_num == goal_num then
      ti.after(2, function()
        gs.push(states.score, {lvl_num = self.lvl_num, score = score})
      end)
    end
  end
end

return state
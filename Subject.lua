local Subject= class('Subject')

function Subject:initialize(args)
  self.x = args.x
  self.y = args.y
  self.w = args.w
  self.h = args.h
  self.id = args.id
  self.active = true
  self.points = args.points or 100
  self.view_state = 'none'
end

function Subject:update(interaction)
  if self.active then
    if interaction == 'contains' and self.view_state ~= 'contains' then
      -- play beep
      sfx.beep:play()
    end

    self.view_state = interaction
  end
end

function Subject:drawFocus()
  lg.setLineWidth(4)
  lg.setColor(0,1,0)
  lg.rectangle('line', self.x, self.y, self.w, self.h)
  lg.ellipse('line', self.x + self.w / 2, self.y + self.h / 2, 30, 30)
  lg.line(self.x + self.w / 2 - 40, self.y + self.h / 2, self.x + self.w / 2 + 40, self.y + self.h / 2)
  lg.setColor(1,1,1)
end

function Subject:draw()
  if self.active and self.view_state == 'contains' then
    self:drawFocus()
  end
end

function Subject:sleep()
  self.active = false

  return self.points
end

return Subject
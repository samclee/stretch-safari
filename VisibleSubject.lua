local VisibleSubject= class('VisibleSubject', Subject)

function VisibleSubject:initialize(args)
  Subject:initialize(args)
  self.idle_spr = sprites[args.idle_spr]
  self.notice_spr = sprites[args.notice_spr]
end

function VisibleSubject:draw()
  if self.active and self.view_state == 'contains' then
    lg.draw(self.notice_spr, self.x, self.y)
    self:drawFocus()
  else
    lg.draw(self.idle_spr, self.x, self.y)
  end
end

return VisibleSubject
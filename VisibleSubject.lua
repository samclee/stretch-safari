local VisibleSubject= class('VisibleSubject', Subject)

function VisibleSubject:initialize(args)
  Subject.initialize(self, args)
  self.idle_spr = args.idle_spr
  self.notice_spr = args.notice_spr
end

function VisibleSubject:draw()
  if self.active and self.view_state == 'contains' then
    lg.draw(sprites[self.notice_spr], self.x, self.y)
    self:drawFocus()
  else
    lg.draw(sprites[self.idle_spr], self.x, self.y)
  end
end

return VisibleSubject
local MovingSubject= class('MovingSubject', VisibleSubject)

function MovingSubject:initialize(args)
  VisibleSubject:initialize(args)

  self.dir = 1
end

function MovingSubject:update(interaction)
  VisibleSubject:update(interaction)

  self.x = self.x + 10 * self.dir

  if self.x > 900 - self.w then
    self.x = 900 - self.w
    self.dir = -1
  elseif self.x < 0 then
    self.x = 0
    dir = 1
  end

end

return MovingSubject
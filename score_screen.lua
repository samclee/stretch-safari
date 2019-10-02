local state = {}

function state:enter(from, opts)
  self.from = from
  self.next = opts.lvl_num + 1
  self.game_over = self.next > 2
end

function state:draw()
  if self.game_over then
    lg.printf('Thanks for playing!\n\nPress <space> to quit',0,10,lg.getWidth(),'center')
  else
    lg.printf('Find all the animals!\n\nPress <space> to start',0,10,lg.getWidth(),'center')
  end
end

function state:keypressed(k)
  if k == 'space' then
    if self.game_over then
      le.quit()    
    else
      gs.pop({lvl_num = self.next})
    end
  end
end

return state
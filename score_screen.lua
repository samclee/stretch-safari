local state = {}

function state:enter(from, opts)
  self.from = from
  self.next = opts.lvl_num + 1
  self.game_over = self.next > 2
end

function state:draw()
  if self.game_over then
    
  else

  end
end


function state:update(dt)

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
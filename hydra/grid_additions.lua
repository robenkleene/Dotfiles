ext.grid_additions = {}

function ext.grid_additions.pushwindow_hard_left()
  ext.grid.adjust_focused_window(function(f) f.x = 0 end)
end

function ext.grid_additions.pushwindow_hard_right()
  ext.grid.adjust_focused_window(function(f) f.x = (ext.grid.GRIDWIDTH - f.w) end)
end

function ext.grid_additions.pushwindow_hard_down()
  ext.grid.adjust_focused_window(function(f) f.y = (ext.grid.GRIDHEIGHT - f.h) end)
end

function ext.grid_additions.pushwindow_hard_up()
  ext.grid.adjust_focused_window(function(f) f.y = 0 end)
end

function ext.grid_additions.resizewindow_hard_wider()
  ext.grid.adjust_focused_window(function(f) f.w = (ext.grid.GRIDWIDTH - f.x) end)
end

function ext.grid_additions.resizewindow_hard_shorter()
  ext.grid.adjust_focused_window(function(f) f.y = f.y - 0; f.h = 1 end)
end

function ext.grid_additions.resizewindow_hard_thinner()
  ext.grid.adjust_focused_window(function(f) f.w = 1 end)
end

function ext.grid_additions.resizewindow_hard_taller()
  ext.grid.adjust_focused_window(function(f) f.y = f.y - 0; f.h = (ext.grid.GRIDHEIGHT - f.y) end)
end

-- Inverse

-- function ext.grid_additions.resizewindow_inverse_wider()
--   ext.grid.adjust_focused_window(function(f) f.w = math.min(f.w + 1, ext.grid.GRIDWIDTH - f.x); f.x = math.max(f.x - 1, 0) end)
-- end
--
-- function ext.grid_additions.resizewindow_inverse_thinner()
--   ext.grid.adjust_focused_window(function(f) f.w = math.max(f.w - 1, 1); f.x = math.min(f.x + 1, ext.grid.GRIDWIDTH - f.w) end)
-- end
--
-- function ext.grid_additions.resizewindow_inverse_shorter()
--   ext.grid.adjust_focused_window(function(f) f.y = f.y - 0; f.h = math.max(f.h - 1, 1); f.y = math.min(f.y + 1, ext.grid.GRIDHEIGHT - f.h) end)
-- end
--
-- function ext.grid_additions.resizewindow_inverse_taller()
--   ext.grid.adjust_focused_window(function(f) f.y = f.y - 0; f.h = math.min(f.h + 1, ext.grid.GRIDHEIGHT - f.y); f.y = math.max(f.y - 1, 0) end)
-- end
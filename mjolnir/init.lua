local hotkey = require "mjolnir.hotkey"
local grid = require "mjolnir.sd.grid"

grid.GRIDWIDTH = 6
grid.GRIDHEIGHT = 3
grid.MARGINX = 0
grid.MARGINY = 0

-- Version 0.1-1 of `mjolnir.sd.grid` didn't support "shorter" but a future version should
function grid.resizewindow_shorter()
  grid.adjust_focused_window(function(f) f.y = f.y - 0; f.h = math.max(f.h - 1, 1) end)
end

mash = {"alt"}
hotkey.bind(mash, 'J', grid.pushwindow_down)
hotkey.bind(mash, 'K', grid.pushwindow_up)
hotkey.bind(mash, 'H', grid.pushwindow_left)
hotkey.bind(mash, 'L', grid.pushwindow_right)

mash = {"ctrl", "alt"}
hotkey.bind(mash, 'k', grid.resizewindow_shorter)
hotkey.bind(mash, 'l', grid.resizewindow_wider)
hotkey.bind(mash, 'h', grid.resizewindow_thinner)
hotkey.bind(mash, 'j', grid.resizewindow_taller)

mash = {"alt"}
hotkey.bind(mash, 'n', grid.pushwindow_nextscreen)
hotkey.bind(mash, 'p', grid.pushwindow_prevscreen)



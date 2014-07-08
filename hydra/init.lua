require "grid"
require "menu"

hydra.alert("Config Loaded", 0.5)

hydra.putindock(true)

-- Uncomment this if you want Hydra to make sure it launches at login
-- autolaunch.set(true)

-- I've worked hard to make Hydra useful and easy to use. I've also
-- released it with a liberal open source license, so that you can do
-- with it as you please. So, instead of charging for licenses, I'm
-- asking for donations. If you find it helpful, I encourage you to
-- donate what you believe would have been a fair price for a license:
-- hotkey.bind({"cmd", "alt", "ctrl"}, "D", donate)

-- move the window to the right half of the screen
function movewindow_righthalf()
  local win = window.focusedwindow()
  local newframe = win:screen():frame_without_dock_or_menu()
  newframe.w = newframe.w / 2
  newframe.x = newframe.x + newframe.w -- comment this line to push it to left half of screen
  win:setframe(newframe)
end

function movewindow_lefthalf()
  local win = window.focusedwindow()
  local newframe = win:screen():frame_without_dock_or_menu()
  newframe.w = newframe.w / 2
  win:setframe(newframe)
end

hotkey.bind({"cmd", "ctrl", "alt"}, "R", repl.open)

local mash = {"alt"}
local mash2 = {"ctrl", "alt"}
local mash3 = {"ctrl", "alt", "shift"}

hotkey.bind(mash, 'h', function() window.focusedwindow():focuswindow_west() end)
hotkey.bind(mash, 'l', function() window.focusedwindow():focuswindow_east() end)
hotkey.bind(mash, 'k', function() window.focusedwindow():focuswindow_north() end)
hotkey.bind(mash, 'j', function() window.focusedwindow():focuswindow_south() end)

hotkey.new(mash2, "h", movewindow_lefthalf):enable()
hotkey.new(mash2, "l", movewindow_righthalf):enable()

hotkey.bind(mash3, 'l', ext.grid.pushwindow_nextscreen)
hotkey.bind(mash3, 'h', ext.grid.pushwindow_prevscreen)

-- hotkey.bind(mash2, 'J', ext.grid.pushwindow_down)
-- hotkey.bind(mash2, 'K', ext.grid.pushwindow_up)
-- hotkey.bind(mash2, 'H', ext.grid.pushwindow_left)
-- hotkey.bind(mash2, 'L', ext.grid.pushwindow_right)
--
-- hotkey.bind(mash2, 'U', ext.grid.resizewindow_taller)
-- hotkey.bind(mash2, 'O', ext.grid.resizewindow_wider)
-- hotkey.bind(mash2, 'I', ext.grid.resizewindow_thinner)
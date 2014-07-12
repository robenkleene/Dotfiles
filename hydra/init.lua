require "grid"
-- dofile(package.searchpath("grid", package.path))
require "grid_additions"
-- dofile(package.searchpath("grid_additions", package.path))
require "menu"
-- dofile(package.searchpath("menu", package.path))

-- dofile(package.searchpath("test", package.path))

show_menu()

notify.show("Config Loaded", "Hydra is here.", "", "")

-- Uncomment this if you want Hydra to make sure it launches at login
-- autolaunch.set(true)

-- move the window to the right half of the screen
-- function movewindow_righthalf()
--   local win = window.focusedwindow()
--   local newframe = win:screen():frame_without_dock_or_menu()
--   newframe.w = newframe.w / 2
--   newframe.x = newframe.x + newframe.w -- comment this line to push it to left half of screen
--   win:setframe(newframe)
-- end
--
-- function movewindow_lefthalf()
--   local win = window.focusedwindow()
--   local newframe = win:screen():frame_without_dock_or_menu()
--   newframe.w = newframe.w / 2
--   win:setframe(newframe)
-- end

-- Grid
ext.grid.GRIDWIDTH = 6
ext.grid.GRIDHEIGHT = 3
ext.grid.MARGINX = 0
ext.grid.MARGINY = 0

-- hotkey.bind({"cmd", "ctrl", "alt"}, "R", repl.open)

local mash = {"alt"}

mash = {"alt"}
hotkey.bind(mash, 'a', function() window.focusedwindow():focuswindow_west() end)
hotkey.bind(mash, 'd', function() window.focusedwindow():focuswindow_east() end)
hotkey.bind(mash, 'w', function() window.focusedwindow():focuswindow_north() end)
hotkey.bind(mash, 's', function() window.focusedwindow():focuswindow_south() end)

mash = {"alt"}
hotkey.bind(mash, 'J', ext.grid.pushwindow_down)
hotkey.bind(mash, 'K', ext.grid.pushwindow_up)
hotkey.bind(mash, 'H', ext.grid.pushwindow_left)
hotkey.bind(mash, 'L', ext.grid.pushwindow_right)

mash = {"alt", "shift"}
hotkey.bind(mash, 'J', ext.grid_additions.pushwindow_hard_down)
hotkey.bind(mash, 'K', ext.grid_additions.pushwindow_hard_up)
hotkey.bind(mash, 'H', ext.grid_additions.pushwindow_hard_left)
hotkey.bind(mash, 'L', ext.grid_additions.pushwindow_hard_right)

mash = {"ctrl", "alt"}
hotkey.bind(mash, 'k', ext.grid.resizewindow_taller)
hotkey.bind(mash, 'l', ext.grid.resizewindow_wider)
hotkey.bind(mash, 'h', ext.grid.resizewindow_thinner)
hotkey.bind(mash, 'j', ext.grid.resizewindow_shorter)

-- mash = {"ctrl"}
-- hotkey.bind(mash, 'k', ext.grid_additions.resizewindow_inverse_shorter)
-- hotkey.bind(mash, 'l', ext.grid_additions.resizewindow_inverse_thinner)
-- hotkey.bind(mash, 'h', ext.grid_additions.resizewindow_inverse_wider)
-- hotkey.bind(mash, 'j', ext.grid_additions.resizewindow_inverse_taller)


mash = {"ctrl", "alt", "shift"}
hotkey.bind(mash, 'k', ext.grid_additions.resizewindow_hard_taller)
hotkey.bind(mash, 'l', ext.grid_additions.resizewindow_hard_wider)
hotkey.bind(mash, 'h', ext.grid_additions.resizewindow_hard_thinner)
hotkey.bind(mash, 'j', ext.grid_additions.resizewindow_hard_shorter)

mash = {"ctrl", "alt", "shift"}
hotkey.bind(mash, 'z', ext.grid.maximize_window)


mash = {"alt"}
hotkey.bind(mash, 'n', ext.grid.pushwindow_nextscreen)
hotkey.bind(mash, 'p', ext.grid.pushwindow_prevscreen)

hotkey.bind({"alt", "shift"}, "s", function() snap_to_grid() end)
hotkey.bind({"alt"}, "s", function() ext.grid.snap(window.focusedwindow()) end)

-- hotkey.new(mash2, "h", movewindow_lefthalf):enable()
-- hotkey.new(mash2, "l", movewindow_righthalf):enable()

-- mash = {"alt"}

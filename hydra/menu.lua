function close_hydra_windows()
  local hydra_app = fnutils.find(application.applicationsforbundleid("org.degutis.Hydra"), function(app) return app:title() == "Hydra" end)
  fnutils.each(hydra_app:allwindows(), function(window) window:close() end)
end

function open_hydra_windows()
  -- repl.open()
  logger.show()
end

function toggle_repl()
  if hydra.indock() then
    close_hydra_windows()
	hydra.dockicon.hide()
  else
    hydra.dockicon.show()
    open_hydra_windows()
  end
end

function snap_to_grid()
  fnutils.map(window.visiblewindows(), ext.grid.snap)
end

function snap_window_to_grid()
  ext.grid.snap(window.focusedwindow())
end


hydra.menu.show(function()
    local t = {
		{title = "About", fn = hydra.showabout},
		{title = "Check for Updates...", fn = function() hydra.updates.check(nil, true) end},
		{title = "-"},
		{title = "Snap to Grid", fn = snap_to_grid},
		{title = "Snap Window to Grid", fn = snap_window_to_grid},
		{title = "-"},
		{title = "Reload Config", fn = hydra.reload},
		{title = "Toggle Dev Tools", fn = toggle_dev_tools},
		{title = "-"},
		{title = "Quit Hydra", fn = os.exit},
    }

    if not hydra.license.haslicense() then
      table.insert(t, 1, {title = "Buy or Enter License...", fn = hydra.license.enter})
      table.insert(t, 2, {title = "-"})
    end

    return t
end)


-- From Default

-- when the "update is available" notification is clicked, open the website
notify.register("showupdate", function() os.execute('open https://github.com/sdegutis/Hydra/releases') end)

-- check for updates every week, and also right now (when first launching)
timer.new(timer.weeks(1), hydra.updates.check):start()
hydra.updates.check()
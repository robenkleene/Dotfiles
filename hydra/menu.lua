-- save the time when updates are checked
function checkforupdates()
  updates.check()
  settings.set('lastcheckedupdates', os.time())
end

function close_hydra_windows()
  local hydra_app = fnutils.find(application.applicationsforbundleid("org.degutis.Hydra"), function(app) return app:title() == "Hydra" end)
  fnutils.each(hydra_app:allwindows(), function(window) window:close() end)
end

function open_hydra_windows()
  repl.open()
  logger.show()
end

function toggle_repl()
  if hydra.indock() then
    close_hydra_windows()
    hydra.putindock(false)
  else
    hydra.putindock(true)
    open_hydra_windows()
  end
end

function snap_to_grid()
  fnutils.map(window.visiblewindows(), ext.grid.snap)
end

function snap_window_to_grid()
  ext.grid.snap(window.focusedwindow())
end

function show_menu()
  menu.show(function()
      local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
      local updatefns = {[true] = updates.install, [false] = checkforupdates}
      local hasupdate = (updates.newversion ~= nil)

      return {
        {title = "About", fn = hydra.showabout},
        {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
        {title = "-"},
        {title = "Snap to Grid", fn = snap_to_grid},
        {title = "Snap Window to Grid", fn = snap_window_to_grid},
        {title = "-"},
        {title = "Reload Config", fn = hydra.reload},
        {title = "Toggle Dev Tools", fn = toggle_repl},
        {title = "-"},
        {title = "Quit Hydra", fn = os.exit},
      }
  end)
end


-- From Default

-- show available updates
local function showupdate()
  os.execute('open https://github.com/sdegutis/Hydra/releases')
end

-- save the time when updates are checked
function checkforupdates()
  updates.check(function(available)
      -- what to do when an update is checked
      if available then
        notify.show("Hydra update available", "", "Click here to see the changelog and maybe even install it", "showupdate")
      else
        notify.show("No update available", "", "", "")
      end
  end)
  settings.set('lastcheckedupdates', os.time())
end

-- check for updates every week
timer.new(timer.weeks(1), checkforupdates):start()
notify.register("showupdate", showupdate)

-- if this is your first time running Hydra, or you're launching it more than a week later, check now
local lastcheckedupdates = settings.get('lastcheckedupdates')
if lastcheckedupdates == nil or lastcheckedupdates <= os.time() - timer.days(7) then
  checkforupdates()
end
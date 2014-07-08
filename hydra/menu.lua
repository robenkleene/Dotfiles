-- save the time when updates are checked
function checkforupdates()
  updates.check()
  settings.set('lastcheckedupdates', os.time())
end


-- menu.show(function()
--     local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
--     local updatefns = {[true] = updates.install, [false] = checkforupdates}
--     local hasupdate = (updates.newversion ~= nil)
--
--     return {
--       {title = "Reload Config", fn = hydra.reload},
--       {title = "Open REPL", fn = repl.open},
--       {title = "-"},
--       {title = "About", fn = hydra.showabout},
--       {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
--       {title = "Quit Hydra", fn = os.exit},
--     }
-- end)



function show_menu()
  menu.show(function()
      local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
      local updatefns = {[true] = updates.install, [false] = checkforupdates}
      local hasupdate = (updates.newversion ~= nil)

      return {
        {title = "Reload Config", fn = hydra.reload},
        {title = "Open REPL", fn = repl.open},
        {title = "-"},
        {title = "About", fn = hydra.showabout},
        {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
        {title = "Quit Hydra", fn = os.exit},
      }
  end)
end
show_menu()


-- show available updates
local function showupdate()
  os.execute('open https://github.com/sdegutis/Hydra/releases')
end

-- what to do when an update is checked
function updates.available(available)
  if available then
    notify.show("Hydra update available", "", "Click here to see the changelog and maybe even install it", "showupdate")
  else
    hydra.alert("No update available.")
  end
end

-- check for updates every week
timer.new(timer.weeks(1), checkforupdates):start()
notify.register("showupdate", showupdate)

-- if this is your first time running Hydra, you're launching it more than a week later, check now
local lastcheckedupdates = settings.get('lastcheckedupdates')
if lastcheckedupdates == nil or lastcheckedupdates <= os.time() - timer.days(7) then
  checkforupdates()
end

local function donate()
  -- Donate via PayPal (default)
  os.execute("open 'https://www.paypal.com/cgi-bin/webscr?business=sbdegutis@gmail.com&cmd=_donations&item_name=Hydra.app%20donation'")

  -- Donate via Gittip (inherently recurring)
  -- os.execute("open https://www.gittip.com/sdegutis/")

  -- Donate via Bitcoin: 18LEhURYNgkC9PPdtdXShDoyaHXGaLENe7
  -- hydra.alert("Bitcoin address: 18LEhURYNgkC9PPdtdXShDoyaHXGaLENe7")
end

" Conflicts with `:E` to `:Explore`
if exists(':EditorConfigEnable')
  delcommand EditorConfigEnable
  delcommand EditorConfigDisable
  delcommand EditorConfigReload
endif

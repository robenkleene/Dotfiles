if !exists(':Alias')
  finish
endif

Alias G Git
Alias A Rg
Alias Ts TigStatus
Alias Tmp TmuxPaths
Alias Af Rg\ -F
" Plugins
Alias -range Ld Linediff
Alias Ldr LinediffReset
" Sessions
Alias SRS SessionRestoreSaved
Alias SSL SessionSaveLocal
Alias SRL SessionRestoreLocal
Alias SS SessionSave
Alias SR SessionRestoreAuto
Alias SRA SessionRestoreAuto
Alias Q QuitSaveSession
" Compilers
Alias CXC compiler\ xcodebuild

# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#


nodepath = process.env.HOME + "/Dotfiles/nvm-fish/v0.11.10/bin"
npmpath = "/usr/local/share/npm/bin"
localbinpath = "/usr/local/bin"
process.env.PATH = [nodepath, npmpath, localbinpath, process.env.PATH].join(':')
# process.env.SHELL = "/bin/bash"
# process.env.ATOM_REPOS_HOME = process.env.HOME + "/Development/Projects/Atom"
process.env.COFFEELINT_CONFIG = process.env.HOME + "/.coffeelint.json"
process.env.ATOM_PATH = process.env.HOME + "/Applications/"

# console.log process.env

# Open in Default Application
atom.workspaceView.command 'roben-kleene:open-in-default-application', ->
  editor = atom.workspace.activePaneItem
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open \"#{filepath}\""

# Open in Terminal
atom.workspaceView.command 'roben-kleene:open-in-terminal', ->
  editor = atom.workspace.activePaneItem
  filepath = editor.getBuffer().getPath()
  path = require('path')
  dirpath = path.dirname(filepath)
  exec = require('child_process').exec
  exec "open -a Terminal \"#{dirpath}\""

# Reveal in Finder
atom.workspaceView.command 'roben-kleene:reveal-in-finder', ->
  editor = atom.workspace.activePaneItem
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open -R \"#{filepath}\""

# Send to LaunchBar
atom.workspaceView.command 'roben-kleene:send-to-launchbar', ->
  editor = atom.workspace.activePaneItem
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "osascript -e 'tell application \"LaunchBar\" to open \"#{filepath}\"'"

# Open Scratch For Scope
atom.workspaceView.command 'roben-kleene:open-scratch-for-scope', ->
  scratchpath = process.env.HOME + "/Development/Scratch/Atom/"
  editor = atom.workspace.activePaneItem
  scope = editor.getGrammar()?.scopeName
  if scope
    filepath = scratchpath + scope
    exec = require('child_process').exec
    exec "atom --new-window \"#{filepath}\""


# if not atom.packages.isPackageDisabled "vim-mode"
#   atom.workspaceView.eachEditorView (editorView) ->
#     editorView.trigger "vim-mode:activate-insert-mode"

console.log "Hello from init.coffee!"

# Emmet
# if !atom.packages.isPackageDisabled('emmet')
#   atom.packages.disablePackage('emmet') # Disable on startup
# atom.workspaceView.command 'roben-kleene:toggle-emmet', ->
#   if atom.packages.isPackageDisabled('emmet')
#     atom.packages.enablePackage('emmet')
#   else
#     atom.packages.disablePackage('emmet')

# Language Specific Settings
# TODO What's the callback for a grammar change?

# Markdown
atom.workspaceView.eachEditorView (editorView) ->
  editor = editorView.getEditor()
  path = require 'path'
  MARKDOWN_EXTENSIONS = ['.md', '.markdown']
  extension = path.extname(editor.getPath())
  if MARKDOWN_EXTENSIONS.indexOf(extension) isnt -1
    editor.setSoftWrap(true)

# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#
path = require 'path'
nodeBinPath = path.join(process.env.HOME, ".nvm/versions/node/v0.12.2/bin")
rubyBinPath = path.join(process.env.HOME, ".rbenv/shims/")
localBinPath = "/usr/local/bin"
process.env.PATH = [nodeBinPath, rubyBinPath, localBinPath, process.env.PATH].join(':')
# process.env.SHELL = "/bin/bash"
# process.env.ATOM_REPOS_HOME = process.env.HOME + "/Development/Projects/Atom"

# The `linter-coffeelint` package no longer supports the `COFFEELINT_CONFIG`
# environment variable because internally it uses `configfinder.coffee` to find
# a config rather than the command line program, which is the only place where
# `COFFEELINT_CONFIG` is supported. This is left in in case it starts working
# in the future.
process.env.COFFEELINT_CONFIG = process.env.HOME + "/.coffeelint.json"
process.env.ATOM_PATH = process.env.HOME + "/Applications/"

# console.log process.env

# Hide Tree View on Startup
# This doesn't seem to work anymore
# workspaceView = atom.views.getView(atom.workspace)
# if (workspaceView.querySelector('.tree-view'))
#   atom.commands.dispatch(workspaceView, 'tree-view:toggle')

# Open in Default Application
atom.commands.add 'atom-text-editor', 'roben-kleene:open-in-default-application', ->
  editor = atom.workspace.getActiveTextEditor()
  filePath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open \"#{filePath}\""

# Open in Terminal
atom.commands.add 'atom-text-editor', 'roben-kleene:open-in-terminal', ->
  editor = atom.workspace.getActiveTextEditor()
  filePath = editor.getBuffer().getPath()
  path = require('path')
  directoryPath = path.dirname(filePath)
  exec = require('child_process').exec
  exec "open -a Terminal \"#{directoryPath}\""

# Reveal in Finder
atom.commands.add 'atom-text-editor', 'roben-kleene:reveal-in-finder', ->
  editor = atom.workspace.getActiveTextEditor()
  filePath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open --reveal \"#{filePath}\""

# Send to LaunchBar
# atom.commands.add 'atom-text-editor', 'roben-kleene:send-to-launchbar', ->
#   editor = atom.workspace.getActiveTextEditor()
#   filePath = editor.getBuffer().getPath()
#   exec = require('child_process').exec
#   exec "osascript -e 'tell application \"LaunchBar\" to open \"#{filePath}\"'"

# Open Scratch For Scope
atom.commands.add 'atom-text-editor', 'roben-kleene:open-scratch-for-scope', ->
  scratchPath = process.env.HOME + "/Development/Scratch/Source/"
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getGrammar()?.scopeName
  if scope
    filePath = scratchPath + scope
    exec = require('child_process').exec
    exec "atom \"#{filePath}\""

atom.commands.add 'atom-text-editor', 'roben-kleene:open-project-in-new-window', ->
  directoryPaths = atom.project.getPaths()
  directoryPath = directoryPaths[0]
  if directoryPath
    exec = require('child_process').exec
    exec "atom --new-window \"#{directoryPath}\""

console.log "Hello from init.coffee!"

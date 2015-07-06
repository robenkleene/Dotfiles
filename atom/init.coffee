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

# Hide Tree View
workspaceView = atom.views.getView(atom.workspace)
if (workspaceView.querySelector('.tree-view'))
  atom.commands.dispatch(workspaceView, 'tree-view:toggle')

# Open in Default Application
atom.commands.add 'atom-text-editor', 'roben-kleene:open-in-default-application', ->
  editor = atom.workspace.getActiveTextEditor()
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open \"#{filepath}\""

# Open in Terminal
atom.commands.add 'atom-text-editor', 'roben-kleene:open-in-terminal', ->
  editor = atom.workspace.getActiveTextEditor()
  filepath = editor.getBuffer().getPath()
  path = require('path')
  dirpath = path.dirname(filepath)
  exec = require('child_process').exec
  exec "open -a Terminal \"#{dirpath}\""

# Reveal in Finder
atom.commands.add 'atom-text-editor', 'roben-kleene:reveal-in-finder', ->
  editor = atom.workspace.getActiveTextEditor()
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open -R \"#{filepath}\""

# Send to LaunchBar
atom.commands.add 'atom-text-editor', 'roben-kleene:send-to-launchbar', ->
  editor = atom.workspace.getActiveTextEditor()
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "osascript -e 'tell application \"LaunchBar\" to open \"#{filepath}\"'"

# Open Scratch For Scope
atom.commands.add 'atom-text-editor', 'roben-kleene:open-scratch-for-scope', ->
  scratchpath = process.env.HOME + "/Development/Scratch/Temp/"
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getGrammar()?.scopeName
  if scope
    filepath = scratchpath + scope
    exec = require('child_process').exec
    exec "atom --new-window \"#{filepath}\""

# if not atom.packages.isPackageDisabled "vim-mode"
#   atom.workspaceView.eachEditorView (editorView) ->
#     editorView.trigger "vim-mode:activate-insert-mode"

# Emmet
# if !atom.packages.isPackageDisabled('emmet')
#   atom.packages.disablePackage('emmet') # Disable on startup
# atom.workspaceView.command 'roben-kleene:toggle-emmet', ->
#   if atom.packages.isPackageDisabled('emmet')
#     atom.packages.enablePackage('emmet')
#   else
#     atom.packages.disablePackage('emmet')

# Language Specific Settings
# Set with `.editorconfig`
# setupGrammarForEditor = (editor) ->
#   scope = editor.getGrammar()?.scopeName
#   switch scope
#     when 'source.coffee'
#       editor.setTabLength(2)
#     when 'source.gfm'
#       editor.setSoftWrap(true)
#     else
#       editor.setTabLength(4)
# # Call on Startup
# atom.workspaceView.eachEditorView (editorView) ->
#   editor = editorView.getEditor()
#   setupGrammarForEditor(editor)
# # Call when a grammar changes
# atom.workspace.observeTextEditors (editor) ->
#   grammarChangedHandler = ->
#     setupGrammarForEditor(editor)
#   editor.onDidChangeGrammar(grammarChangedHandler)
#
console.log "Hello from init.coffee!"

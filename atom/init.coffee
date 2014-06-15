# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#

path = require 'path'
atom.workspaceView.eachEditorView (editorView) ->
  editor = editorView.getEditor()
  if path.extname(editor.getPath()) is '.md'
    editor.setSoftWrap(true)

atom.workspaceView.command 'roben-kleene:copy-markdown-link-to-file', ->
  editor = atom.workspace.activePaneItem
  selection = editor.getSelection()
  title = editor.getTitle()
  console.log "copy-markdown-link-to-file\nselection = #{selection}\ntitle = #{title}"

exec = require('child_process').exec
atom.workspaceView.command 'roben-kleene:open-in-default-application', ->
  editor = atom.workspace.activePaneItem
  filepath = editor.getBuffer().getPath()
  exec = require('child_process').exec
  exec "open #{filepath}"

console.log "Hello from init.coffee!"

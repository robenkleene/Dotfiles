#!/usr/bin/env ruby

require 'webconsole'

PLUGIN_NAME = "Coffee"

directory = ARGV[0]

text = STDIN.read
text.gsub!("\n", "\uFF00") # \uFF00 is the unicode character Coffee uses for new lines
text = text + "\n"

if !directory 
  directory = Dir.pwd
end

window_id = WebConsole::window_id_for_plugin(PLUGIN_NAME)
if !window_id
  window_id = WebConsole::run_plugin(PLUGIN_NAME, directory)
end

window = WebConsole::Window.new(window_id)
window.read_from_standard_input(text)
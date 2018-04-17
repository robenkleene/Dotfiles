#!/usr/bin/env ruby

require 'webconsole'

PLUGIN_NAME = "Markdown"

if ARGV.empty?
  puts "No file specified"
  exit
end

file = ARGF.file
file_path = File.expand_path(file)

# TODO Specifying a directory here event though it isn't necessary for this plugin is sort of inelegant, perhaps running a plugin shouldn't require a directory? What would the intelligent default be? Probably the plugins default directory?
directory = Dir.pwd

WebConsole::run_plugin(PLUGIN_NAME, directory, [file_path])
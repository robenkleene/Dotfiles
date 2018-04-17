#!/usr/bin/env ruby

require 'webconsole'

PLUGIN_NAME = "Search"

term = ARGV[0]
directory = ARGV[1]

if !directory 
  directory = Dir.pwd
end

WebConsole::run_plugin(PLUGIN_NAME, directory, [term])
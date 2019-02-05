#!/usr/bin/env ruby

require 'pathname'

abort("Wrong number of arguments") unless ARGV.count != 2
file_one = ARGV[0]
file_two = ARGV[1]
abort("#{file_one} does not exist") unless File.exists?(file_one)
abort("#{file_two} does not exist") unless File.exists?(file_two)

puts Pathname.new(file_one).relative_path_from(Pathname.new(file_two)).to_s

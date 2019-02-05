#!/usr/bin/env ruby

require 'pathname'

abort("Wrong number of arguments") unless ARGV.count == 2
file_one = File.expand_path(ARGV[0])
file_two = File.expand_path(ARGV[1])
abort("#{file_one} does not exist") unless File.exists?(file_one)
abort("#{file_two} does not exist") unless File.exists?(file_two)

if File.file?(file_one)
  # `relative_path_from` has an extra path component if the filename is
  # included in the path
  file_one = File.dirname(file_one)
end

puts Pathname.new(file_two).relative_path_from(Pathname.new(file_one)).to_s

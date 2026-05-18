#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'

abort('Wrong number of arguments') unless [1, 2].include?(ARGV.count)
target = File.expand_path(ARGV[0])
# Default the base to the current directory when only one argument is given
base = ARGV[1] ? File.expand_path(ARGV[1]) : Dir.pwd
abort("#{target} does not exist") unless File.exist?(target)
abort("#{base} does not exist") unless File.exist?(base)

if File.file?(base)
  # `relative_path_from` has an extra path component if the filename is
  # included in the path
  base = File.dirname(base)
end

puts Pathname.new(target).relative_path_from(Pathname.new(base)).to_s

#!/usr/bin/env ruby

ARGF.each do |line|
  if line =~ /^\s*-/
    line.sub!(/-/, '*')
  elsif line =~ /^\s*\*/
    line.sub!(/\*/, '-')
  end
  puts line
end
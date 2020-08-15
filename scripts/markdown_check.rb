#!/usr/bin/env ruby

require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.on('-u', '--uncheck', 'Uncheck') do |u|
    options[:uncheck] = u
  end
  opts.on('-c', '--check', 'Check') do |u|
    options[:check] = u
  end
  opts.on('-i', '--invert', 'Invert') do |u|
    options[:invert] = u
  end
  opts.on('-b', '--line-break', 'Invert') do |u|
    options[:line_break] = u
  end
end
optparse.parse!

new_line = false
ARGF.each do |line|
  if new_line
    puts
  else
    new_line = true
  end

  line.encode!('UTF-8', 'UTF-8', invalid: :replace)
  result = false
  result = line.gsub!(/^(\s*[-*]\s)\[\s\]\s/, '\1[x] ') if options[:invert] || options[:check]
  line.gsub!(/^(\s*[-*]\s)\[[xX]\]\s/, '\1[ ] ') if (options[:invert] && !result) || options[:uncheck]
  print line.chomp
end
puts if options[:line_break]

#!/usr/bin/env ruby

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
end
optparse.parse!

ARGF.each do |line|
  result = false
  result = line.gsub!(/^(\s*[-*]\s)\[\s\]\s/, '\1 [x] ') if options[:invert] || options[:check]
  line.gsub!(/^(\s*[-*]\s)\[[xX]\]\s/, '\1 [ ] ') if (options[:invert] && !result) || options[:uncheck]
end

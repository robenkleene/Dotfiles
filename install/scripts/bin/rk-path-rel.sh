#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'pathname'

options = {}
OptionParser.new do |opts|
  opts.on('-b', '--base BASE', 'Path to make the paths relative to') do |b|
    options[:base] = b
  end
end.parse!

# Default the base to the current directory when `--base` isn't given
base = options[:base] ? File.expand_path(options[:base]) : Dir.pwd
abort("#{base} does not exist") unless File.exist?(base)

if File.file?(base)
  # `relative_path_from` has an extra path component if the filename is
  # included in the path
  base = File.dirname(base)
end

targets = if ARGV.empty?
            abort('No paths given') if $stdin.tty?
            # `chomp: true` strips the trailing newline from each line
            $stdin.readlines(chomp: true).reject(&:empty?)
          else
            ARGV
          end

targets.each do |path|
  target = File.expand_path(path)
  abort("#{target} does not exist") unless File.exist?(target)
  puts Pathname.new(target).relative_path_from(Pathname.new(base)).to_s
end

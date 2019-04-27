#!/usr/bin/env ruby

require 'open-uri'

if ARGV.empty?
  STDERR.puts "No file specified"
  exit
end

file = ARGF.file

if ARGV.empty?
  postfix = ""
else
  postfix = ARGV[0]
end

# Filename
filename = File.basename(file)

# File URL
file_path = File.expand_path(file)
file_url = URI.escape("file://" + file_path)

# Markdown Link
md_link = "[`#{filename}`](#{file_url}#{postfix})"

print md_link

if !STDIN.tty?
  whitespace = nil
  while line = STDIN.gets
    if !whitespace
      puts ":\n\n"
      if line =~ /^(\s{4}|\t)/
        whitespace = ""
      else
        whitespace = "\t"
      end
    end
    puts whitespace + line
  end
end

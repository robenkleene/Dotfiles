#!/usr/bin/env ruby

require 'open-uri'
require 'shellwords'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.on('-l', '--line-number LINENUMBER', "Line Number") do |l|
    options[:line_number] = l
  end
  opts.on('-u', '--url-only', "URL only") do |u|
    options[:url_only] = u
  end
  opts.on('-q', '--quote', "Quote") do |u|
    options[:quote] = u
  end
end
optparse.parse!

if ARGV.empty?
  puts "No file specified"
  exit 1
end

file = ARGF.file

if ARGV.empty?
  postfix = ""
else
  postfix = ARGV[0]
end

line_number = options[:line_number].to_i
filename = File.basename(file)
directory = File.dirname(file)

source_control_url = `~/.bin/link_source_control -f #{Shellwords.escape(file.path)}`.strip

if source_control_url =~ /^https:\/\/github.com/
  if line_number > 0
    source_control_url << "#L#{line_number}"
  end

  # Process the quoted portion
  if !STDIN.tty?
    quoted = ""
    whitespace = nil
    line_count = 0
    while line = STDIN.gets
      if !whitespace
        quoted << ":\n\n"
        if line =~ /^(\s{4}|\t)/
          whitespace = ""
        else
          whitespace = "\t"
        end
      end
      quoted << "#{whitespace + line}"
      line_count += 1
    end
  end

  if line_number > 0 && line_count > 1
    # `- 1` because the first line is already selected
    source_control_url << "-L#{line_number + line_count - 1}"
  end
end

if options[:url_only]
  puts source_control_url
  exit 0
end

# Markdown Link
file_path = `cd #{Shellwords.escape(directory)} && git ls-tree --full-name --name-only HEAD #{Shellwords.escape(filename)}`.strip
md_link = "[`#{file_path}`](#{source_control_url})"
print md_link
if options[:quote]
  print quoted unless quoted == ""
end

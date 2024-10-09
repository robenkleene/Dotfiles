#!/usr/bin/env ruby

require 'json'
require 'pathname'
require 'optparse'

filename_to_mode = {
  'objective-c' => 'objc',
  'shellscript' => 'sh',
  'javascript' => 'js',
  'global' => 'text',
  'zsh' => nil
}

options = { force: false, overwrite: false }
OptionParser.new do |opts|
  # `./export_code_snippets_to_yasnippet.rb -h` for usage
  opts.banner = 'Usage: ./export_code_snippets_to_yasnippet.rb [options]'
  opts.on('-f', '--force', 'Dry run if missing') do
    options[:force] = true
  end
  opts.on('-o', '--overwrite', 'Overwrite existing files') do
    options[:overwrite] = true
  end
  opts.on('-v', '--verbose', 'Also output templates if dry run') do
    options[:verbose] = true
  end
  opts.on('-s', '--source', 'Snippet source directory') do |s|
    options[:source] = s
  end
  opts.on('-d', '--destination', 'Snippet destination directory') do |d|
    options[:destination] = d
  end
end.parse!

code_snippets_path = options[:source] || "#{Dir.home}/.config/Code/User/snippets"
unless File.directory?(code_snippets_path)
  warn "Code snippets dir #{code_snippets_path} not found"
  exit 1
end

yasnippets_snippets_path = options[:destination] || "#{Dir.home}/.emacs.d/snippets"
unless File.directory?(yasnippets_snippets_path)
  warn "YASnippets snippets dir #{yasnippets_snippets_path} not found"
  exit 1
end

unless options[:force]
  puts 'Dry Run'
  puts
end

Dir.glob("#{code_snippets_path}/*.{json,code-snippets}") do |file_path|
  contents = File.read(file_path)
  json = JSON.parse(contents)
  filename = File.basename(file_path, File.extname(file_path))
  # Skip `package.json` which just defines file type to snippet file mappings
  next if filename == 'package'

  if filename_to_mode.key?(filename) && filename_to_mode[filename].nil?
    puts "Skipping #{filename} because it's mode key is nil"
    next
  end
  mode = filename_to_mode[filename].nil? ? filename : filename_to_mode[filename]
  dest_dir = File.join(yasnippets_snippets_path, "#{mode}-mode")

  json.each do |key, hash|
    prefix = hash['prefix']
    # description = hash['description'] || hash['prefix']
    body = hash['body']
    body = body.join("\n") if body.instance_of?(Array)
    # YAS snippets treats backticks specially, so escape them in snippets
    body.gsub!(/`/, '\\\`')
    template = "# -*- mode: snippet -*-
# key: #{prefix}
# name: #{key}
# --
#{body}"
    dest_path = File.join(dest_dir, prefix)
    if !File.exist?(dest_path) || options[:overwrite]
      if options[:force]
        Dir.mkdir(dest_dir) unless File.exist?(dest_dir)
        unless File.directory?(dest_dir)
          warn "Failed to create dir #{dest_dir}"
          exit 1
        end
        puts "Writing #{dest_path}"
        File.write(dest_path, template)
      else
        puts "Writing #{dest_path}"
        puts "#{template}\n\n" if options[:verbose]
      end
    end
  end
end

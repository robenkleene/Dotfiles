#!/usr/bin/env ruby

require 'open-uri'

term = ARGV[0]

if term.empty?
  STDERR.puts "No search term specified"
  exit
end

escaped_term = URI.escape(term)
if term.empty?
  STDERR.puts "Invalid search term"
  exit
end

base_url = "https://duckduckgo.com/?q="
`open #{base_url}#{escaped_term}`

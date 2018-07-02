#!/usr/bin/env ruby

require 'net/http' 
require 'open-uri'
require 'erb'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.on('-u', '--url-only', "URL only") do |u|
    options[:url_only] = u
  end
end
optparse.parse!

def getLinkForPhrase(phrase)
  request = URI.parse(URI.escape("http://www.google.com/search?q=#{phrase}&btnI=I'm+Feeling+Lucky"))
  # TODO: DuckDuckGo doesn't work for some reason
  # (putting a `\` in front of your search term is the syntax)
  # request = URI.parse("http://www.duckduckgo.com/search?q=\\#{URI.escape(phrase)}")
  response = Net::HTTP.get_response(request)
  url = response.to_hash['location'].to_a.first
  return nil, nil, phrase if url.nil?
  begin
    fp = open(url)
    title = fp.read.match(/<title>([^<>]*)<\/title>/i).to_a[1]
    title = title.strip
    return url, title, phrase
  rescue
    return nil, nil, phrase
  end
end

skipped=false
ARGF.each do |line|
  if !skipped
    skipped = true
  else
    puts
  end
  line.strip!
  if line.empty?
    next
  end
  url, title, input = getLinkForPhrase(line)
  if url.nil?
    print input.chomp
    next
  end
  result = options[:url_only] ? url : "[#{title}](#{url})"
  print result
end

#!/usr/bin/env ruby

require 'nokogiri'

filename = ARGV[0]

if filename.nil? || filename.empty?
  STDERR.puts 'Usage: ./itunes_export_albums.rb Library.xml'
  exit 1
end

doc = Nokogiri::XML(File.open(filename))

track_nodes = doc.xpath('/plist/dict[key=\'Tracks\']/key[.=\'Tracks\']/'\
                        'following-sibling::dict[1]/dict')

# Album
class Album
  attr_accessor :title, :has_video, :is_podcast

  def eql?(other)
    title.to_s == other.title.to_s
  end

  def hash
    title.to_s.hash
  end

  def initialize(title,
                 artist,
                 album_artist = nil,
                 is_compilation = false,
                 has_video = false,
                 is_podcast = false)
    @title = title
    @artist = artist
    @album_artist = album_artist
    @is_compilation = is_compilation
    @has_video = has_video
    @is_podcast = is_podcast
  end

  def best_artist
    return @album_artist unless @album_artist.nil?
    return 'Various Artists' if @is_compilation

    @artist
  end

  def description
    "#{best_artist} - #{@title}"
  end
end

def album_from_element(element)
  title = element.xpath('key[.=\'Album\']/following-sibling::'\
                        'string[1]/text()')
  title = nil if title.empty?
  artist = element.xpath("key[.='Artist']/following-sibling::string[1]/text()")
  artist = nil if artist.empty?
  album_artist = element.xpath('key[.=\'Album Artist\']/following-sibling::'\
                               'string[1]/text()')
  album_artist = nil if album_artist.empty?
  # is_compilation
  compilation_node = element.xpath('key[.=\'Compilation\']/following-sibling::'\
                                   '*[1]')[0]
  is_compilation = !compilation_node.nil? && compilation_node.name == 'true'
  has_video_node = element.xpath('key[.=\'Has Video\']/following-sibling::'\
                                 '*[1]')[0]
  has_video = !has_video_node.nil? && has_video_node.name == 'true'
  podcast_node = element.xpath('key[.=\'Podcast\']/following-sibling::'\
                                   '*[1]')[0]
  is_podcast = !podcast_node.nil? && podcast_node.name == 'true'
  Album.new(title, artist, album_artist, is_compilation, has_video, is_podcast)
end

require 'set'
albums = Set.new

track_nodes.each do |track_dict_element|
  album = album_from_element(track_dict_element)
  albums.add(album) if !album.has_video && !album.is_podcast
end

albums.each do |album|
  puts album.description.to_s
end

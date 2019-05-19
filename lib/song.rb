require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song = self.new
    new_song.save
    new_song
  end

  def self.new_by_name(song_name)
    new_song = self.new
    new_song.name = song_name
    new_song
  end

  def self.create_by_name(song_name)
    new_song = self.new_by_name(song_name)
    new_song.save
    new_song
  end

  def self.find_by_name(song_name)
    self.all.find{|each_song| each_song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    song_needed = self.find_by_name(song_name)
    if song_needed == nil
      song_needed = self.create_by_name(song_name)
    else
      song_needed
    end
  end

  def self.alphabetical
    names_in_order = self.all.map do |each_song|
      each_song.name
    end.sort
    names_in_order.map do |song_name|
      self.find_by_name(song_name)
    end
  end

  def self.new_from_filename(filename_format)
    filename_format.slice!(".mp3")
    song_array = filename_format.split(" - ")
    new_song = self.new_by_name(song_array[1])
    new_song.artist_name = song_array[0]
    new_song
  end

  def self.create_from_filename(filename_format)
    new_song = self.new_from_filename(filename_format)
    self.all << new_song
  end

  def self.destroy_all
    self.all.clear
  end

end
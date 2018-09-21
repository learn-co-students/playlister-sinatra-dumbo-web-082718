class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    string_array = self.name.downcase.split
    string_array.each do |word|
      word.gsub!(/[^0-9A-Za-z]/, '')
    end
    string_array.join("-")
  end

  def self.find_by_slug(slug)
    Song.all.find do |song|
      song.slug == slug
    end
  end
end

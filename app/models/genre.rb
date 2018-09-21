class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    string_array = self.name.downcase.split
    string_array.each do |word|
      word.gsub!(/[^0-9A-Za-z]/, '')
    end
    string_array.join("-")
  end

  def self.find_by_slug(slug)
    Genre.all.find do |genre|
      genre.slug == slug
    end
  end

end

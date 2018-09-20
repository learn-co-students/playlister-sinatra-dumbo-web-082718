class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    string_array = self.name.downcase.split
    string_array.join("-")
  end

  def self.find_by_slug(slug)
    unslug_string = slug.split("-").map {|word|word.capitalize}.join(" ")
    self.find_by(name: unslug_string)
  end
end

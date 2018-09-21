class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    slug_name_with_spaces = self.name.gsub(/[^0-9A-Za-z\s]/, '')
    slug_name_without_spaces = slug_name_with_spaces.gsub(/[\s]/, "-")
    slug_name_without_spaces.downcase
  end

  def self.find_by_slug(input)
    self.all.find do |song|
      song.slug == input
    end
  end
end

class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    string_array = self.name.downcase.split
    string_array.each do |word|
      word.gsub!(/[^0-9A-Za-z]/, '')
    end
    string_array.join("-")
  end

  def self.find_by_slug(slug)
    Artist.all.find do |artist|
      artist.slug == slug
    end
  end

end

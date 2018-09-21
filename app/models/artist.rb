class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    name = self.name
    Slugifiable.slugify(name)
  end

  def self.find_by_slug(slug)
    @artists = self.all
    @artist = @artists.find do |artist|
      artist.slug == slug
    end
  end
end

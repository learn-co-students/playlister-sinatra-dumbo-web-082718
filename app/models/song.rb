class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres


  def slug
    Slugifiable.slugify(self.name)
  end

  def self.find_by_slug(slug)
    @songs = self.all
    @song = @songs.find do |song|
      song.slug == slug
    end
  end
end

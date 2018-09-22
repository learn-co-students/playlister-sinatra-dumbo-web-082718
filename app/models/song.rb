class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres
  before_update :last_updated

  @@last_updated = nil

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    Song.find{|song| song.slug == slug}
  end

  def self.last_updated_id
    @@last_updated
  end

  private
  # before_update
  def last_updated
    @@last_updated = self.id
  end

end

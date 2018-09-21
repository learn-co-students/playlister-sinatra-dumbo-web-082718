class Slugifiable

  def self.slugify(str)
    my_str = str.gsub(/[\s]/,"-")
    new_str =my_str.gsub(/[^a-zA-Z0-9\-]/,"")
  end

  # def self.find_by_slug(slug)
  #   @songs = self.all
  #   @song = @songs.find do |song|
  #     song.slug == slug
  #   end
  # end


end

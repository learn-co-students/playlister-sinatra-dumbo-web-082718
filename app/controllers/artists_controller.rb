class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all.sort_by { |artist| artist.name }.to_a
    erb :'artists/index'
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    @songs = @artist.songs.sort_by { |song| song.name }.to_a
    @genres = @artist.genres.sort_by { |genre| genre.name }.to_a
    erb :'artists/show'
  end

end

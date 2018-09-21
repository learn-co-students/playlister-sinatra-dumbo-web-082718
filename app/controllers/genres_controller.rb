class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all.sort_by { |genre| genre.name }.to_a

    erb :'genres/index'
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    @songs = @genre.songs.sort_by { |song| song.name }.to_a
    @artists = @genre.artists.sort_by { |artist| artist.name }.to_a
    erb :'genres/show'
  end
end

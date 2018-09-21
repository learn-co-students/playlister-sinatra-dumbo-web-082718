class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all

    erb :'genres/index'
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    @songs = @genre.songs.to_a
    @artists = @genre.artists.to_a
    erb :'genres/show'
  end
end

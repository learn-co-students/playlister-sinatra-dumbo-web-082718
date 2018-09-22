class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :"genres/index"
  end

  get '/genres/:slug' do
    @genre = Genre.find{|genre| genre.slug == params[:slug]}
    @artists = @genre.artists
    @songs = @genre.songs
    erb :"genres/show"
  end
end

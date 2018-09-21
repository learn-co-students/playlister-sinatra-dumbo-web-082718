class GenresController < ApplicationController

get '/genres' do
  @genres = Genre.all
  erb :'genre/genres'
end

get '/genres/:slug' do
  @genre = Genre.find_by_slug(params[:slug])
  @genre_genres = @genre.genres
    erb :'genre/shows'
  end


end

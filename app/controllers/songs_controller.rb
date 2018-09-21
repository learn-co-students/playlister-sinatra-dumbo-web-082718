class SongsController < ApplicationController
get '/songs' do
  @songs = Song.all
  erb :'songs/songs'
end
get '/songs/new' do
  @genres = Genre.all

  erb :'songs/new'
end
post '/songs' do
  @artist_id = Artist.find_or_create_by(params[:artist]).id
  @new_song = Song.find_or_create_by(params[:song])
  @new_song.artist_id = @artist_id
  @new_song.save
  # @song = @new_song
  @genres = params[:genres].map do |genre_name|
    @new_song.genres.push(Genre.find_by(name: genre_name))
  end
  @new_song.save
  flash[:message] = "Successfully created song."

  redirect to "/songs/#{@new_song.slug}"
end

get '/songs/:slug/edit' do
  @song = Song.find_by_slug(params[:slug])

  erb :'songs/edit'
end

patch '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])
  @artist_id = Artist.find_or_create_by(params[:artist]).id
  @song.update(name: params[:song][:name], artist_id: @artist_id)
  @genres = params[:genres].map do |genre_name|
    @song.genres.push(Genre.find_by(name: genre_name))
  end
  @song.save
  flash[:message] = "Successfully updated song."
  redirect to "/songs/#{@song.slug}"
end

get '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])
  @song_genres = @song.genres
    erb :'songs/show'
  end



end

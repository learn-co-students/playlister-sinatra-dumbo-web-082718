class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  get '/songs/:slug' do
    @song = Song.find{|song| song.slug == (params[:slug])}
    @artist = @song.artist
    erb :'songs/show'
  end


  post '/songs' do
    # binding.pry
    @song = Song.create(name: params[:song_name])
    @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.genre_ids = params[:genres]
    @song.save
    # binding.pry

    # flash[:message] = "Successfully created song."
    # binding.pry
    redirect("/songs/#{@song.slug}")
  end

  patch '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save
    @last_id = Song.last_updated_id
    # flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end

end

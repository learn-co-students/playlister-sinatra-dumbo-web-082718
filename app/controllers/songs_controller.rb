class SongsController < ApplicationController

  get '/songs' do
    # "Hello World"
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres=Genre.all
    erb :'songs/new'
  end

  post '/songs' do
    # binding.pry
    @song = Song.create(params)
    redirect to '/songs/#{song.slug}'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params["slug"])
    @artist = @song.artist
    @genres= @song.genres
    erb :'songs/show'
  end
end

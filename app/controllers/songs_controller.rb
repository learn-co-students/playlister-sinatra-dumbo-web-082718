require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all.sort_by { |song| song.name }.to_a

    @songs =
    erb :'songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all.sort_by { |artist| artist.name }.to_a
    @genres = Genre.all.sort_by { |genre| genre.name }.to_a

    erb :'songs/new'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @artists = Artist.all.sort_by { |artist| artist.name }.to_a
    @genres = Genre.all.sort_by { |genre| genre.name }.to_a

    erb :'songs/edit'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres

    erb :'songs/show'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @input_genres = Genre.find(params[:genres])
    @song.update(params[:song])
    if params[:artist][:name].empty?
      @song.artist = Artist.find(params[:artist][:id]).first
    else
      @song.artist = Artist.find_or_create_by(name:params[:artist][:name])
    end

    @song.genres = []
    @song.genres << @input_genres

    @song.save

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

  post '/songs' do
    @song = Song.create(params[:song])
    if params[:artist][:name].empty?
      @song.artist = Artist.find(params[:artist][:id]).first
    else
      @song.artist = Artist.find_or_create_by(name:params[:artist][:name])
    end
    @song.genres << Genre.find(params[:genres])
    @song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

end

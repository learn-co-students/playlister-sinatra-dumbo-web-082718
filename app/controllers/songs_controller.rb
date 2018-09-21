require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash
  get '/songs' do
    @songs = Song.all

    erb :'songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all

    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres

    erb :'songs/show'
  end



  post '/songs' do
    # binding.pry
    @song = Song.create(params[:song])
    if !params[:genre_ids].nil?
      @genres = params[:genre_ids].map { |id| Genre.find(id) }
      @song.genres << @genres
    end

    if !params[:artist_id].nil?
      @song.artist = Artist.find(params[:artist_id][0])
    elsif !params[:artist][:name].nil?
      if !Artist.find_by(params[:artist])
        @song.artist = Artist.create(params[:artist])
      end
    # else
    #   @song.artist = "nil"
    end
    @song.save

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

end

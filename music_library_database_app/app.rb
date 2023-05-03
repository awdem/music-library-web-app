# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    
    return erb(:albums)
  end

  get '/albums/:id' do
    @id = params[:id]

    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    album = repo.find(@id)
    
    @title = album.title
    @release_year = album.release_year
    @artist = artist_repo.find(album.artist_id).name
    
    return erb(:albums_by_id) 
  end



  get '/artists' do
    repo = ArtistRepository.new
    list = repo.all.map(&:name).join(", ")
  end

  post '/albums/create-album' do
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo = AlbumRepository.new

    repo.create(new_album)

    return ""
  end

  post '/artists' do
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo = ArtistRepository.new

    repo.create(new_artist)

    return ""
  end



end
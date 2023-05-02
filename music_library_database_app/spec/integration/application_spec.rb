require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'gets a list of all albums' do
    response = get('/albums')

    album_list = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

    expect(response.status).to eq(200)
    expect(response.body).to eq(album_list)
    end
  end
  
  context "POST /albums/create-album" do
    it 'creates a new album record in the database' do
      response = post('/albums/create-album', title: "Little Girl Blue", release_year: 1959, artist_id: 4)

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/albums')

      expect(response.body).to include("Little Girl Blue")
    end

    # these tests don't reset the database so any test after this will have Little Girl Blue as part of the albums table
  end

  context 'GET /artists' do
    it 'gets a list of artist' do
      response = get('/artists')

      artist_list = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to eq(artist_list)
    end
  end

  context 'POST /artists' do
    it 'creates a new artist in the database' do
      response = post('/artists', name: 'The Flaming Lips', genre: 'Alternative Rock')

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/artists')

      expect(response.body).to include('The Flaming Lips')
          # these tests don't reset the database so any test after this will have The Flaming Lips as part of the artists table
    end
  end

end

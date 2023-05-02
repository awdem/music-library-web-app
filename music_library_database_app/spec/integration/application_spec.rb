require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "POST /albums/create-album" do
    it 'gets a list of all albums' do
      response = get('/albums')

      album_list = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

      expect(response.status).to eq(200)
      expect(response.body).to eq(album_list)
    end

    it 'creates a new album record in the database' do
      response = post('/albums/create-album', title: "Little Girl Blue", release_year: 1959, artist_id: 4)

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/albums')

      expect(response.body).to include("Little Girl Blue")
    end
  end

end

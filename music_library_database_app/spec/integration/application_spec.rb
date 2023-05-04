require "spec_helper"
require "rack/test"
require_relative '../../app'

# Test-drive and implement the following change to the music_library_database_app project:

# The page returned by GET /albums should contain a link for each album listed. It should link to /albums/:id, where :id is the corresponding album's id.

# Run the server and make sure you can navigate, using your browser, from the albums list page to the single album page.

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do
    reset_tables
  end

  context "GET /albums" do
    it "returns a list of links to albums as an HTML page" do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include("<a href=\"/albums/1\"> 1. Doolittle <a>")
      expect(response.body).to include("<a href=\"/albums/12\"> 12. Ring Ring <a>")
    end
  end


  context "GET /albums/:id" do
    it "returns the first albums information" do
      response = get('/albums/1')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('Doolittle', 'Release year: 1989', 'Artist: Pixies')
    end

    
  end
  
  context "POST /albums/create-album" do
    it 'creates a new album record in the database' do
      response = post('/albums/create-album', title: "Little Girl Blue", release_year: 1959, artist_id: 4)

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/albums/13')

      expect(response.body).to include("Little Girl Blue")
    end
  end

  context 'GET /artists' do
    it 'gets a list of artist' do
      response = get('/artists')

      artist_list = 'Pixies, ABBA, Taylor Swift, Nina Simone'

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

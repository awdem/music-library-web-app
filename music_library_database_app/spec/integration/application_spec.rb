require "spec_helper"
require "rack/test"
require_relative '../../app'

# Test-drive a route GET /artists/:id which returns an HTML page showing details for a single artist.
# Test-drive a route GET /artists which returns an HTML page with the list of artists. 
#  This page should contain a link for each artist listed, 
#  linking to /artists/:id where :id needs to be the corresponding artist id.

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
      expect(response.body).to include("<a href=\"/albums/1\"> 1. Doolittle </a>")
      expect(response.body).to include("<a href=\"/albums/12\"> 12. Ring Ring </a>")
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
    it 'gets an html page with a links to artists' do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include("<a href=\"/artists/1\"> 1. Pixies </a>")
      expect(response.body).to include("<a href=\"/artists/4\"> 4. Nina Simone </a>")

    end
  end

  context 'GET /artists/:id' do
    it 'returns html page with the first artists details' do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1> Pixies </h1>")
      expect(response.body).to include("<p> Genre: Rock </p>") 
    end
  end

  context 'POST /artists' do
    it 'creates a new artist in the database' do
      response = post('/artists', name: 'The Flaming Lips', genre: 'Alternative Rock')

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/artists')

      expect(response.body).to include('The Flaming Lips')
    end
  end
end

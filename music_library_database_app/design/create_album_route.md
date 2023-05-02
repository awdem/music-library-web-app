# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)


1. Design the route signature

Method: POST
Path: /albums
body_params: title, release_year, artist_id

2. design the response


Status: 200 OK


3. Write examples:

POST /albums, title: "Little Girl Blue", release_year: 1959, artist_id: 4

Expected response: 200 OK


4. Implement as tests
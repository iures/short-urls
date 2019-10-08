# URL Shortening Approach

The short codes  get generated from our domain instance id. Since active
record ids are unique,  we guarantee that there won't be collisions. Because
they change in increments we can use an approach that will generate short
codes in order. 

This solution falls short if in the future we decide to
archive old unused short codes. In that case, we can use a mixed approach
where we first check a pool of persisted available codes.

The algorithm is built around the list of available characters defined by:

    CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

With these characters, we can now create what essentially is a new number 
base of 61 (`CHARACTERS.length`). Our work now is to convert to and from this new base 61.

The logic related to this conversion can be found in the [ShortCodeParser](lib/short_code_parser.rb).


# Intial Setup

    docker-compose build
    docker-compose run short-app rails db:setup && rails db:migrate

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

require('sinatra')
require('haml')
require('json')

require('./dotaheroes.rb')

# Handle home page
get '/' do

	@location = :"blocks/homepage/home"
	@title = "Dota Heroes"

	haml :index

end

# Handle hero data look up
get '/hero/:heroname' do |heroname|

	if Dotaheroes.exist?(heroname)
		@location = :"blocks/hero/heroblock"
	else
		@location = :"blocks/404"
	end

	@title = heroname.capitalize + " - Dota Heroes"

	# Retrieve .hinfo data
	@hero = Dotaheroes.mine(heroname)

	haml :index

end

# Allow querying for list of heroes
get '/list/hero' do

	Dotaheroes.list().to_json

end

require('sinatra')
require('haml')
require('./dotaheroes.rb')

# Handle home page
get '/' do

	@location = :"blocks/homepage/home"
	@title = "Dota Heroes"

	haml :index

end

# Handle hero data look up
get '/hero/:heroname' do |heroname|

	if File.exist?('data/heroes/' + heroname.downcase + '.hinfo')
		@location = :"blocks/hero/heroblock"
	else
		@location = :"blocks/404"
	end

	@title = heroname.capitalize + " - Dota Heroes"

	# Retrieve .hinfo data
	@hero = Dotaheroes.Mine(heroname)

	haml :index

end

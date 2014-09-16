require('sinatra')
require('haml')
require('./dotaheroes.rb')

# Handle home page
get '/' do

	@location = :"blocks/homepage/home"
	haml :index

end

# Handle hero data look up
get '/hero/:heroname' do |heroname|

	# The main content block is the hero block.
	@location = :"blocks/hero/heroblock"

	# MOCK DATA
	@hero = {
		:name => 'Abaddon',
		:image => 'http://i.imgur.com/R67L263.jpg'
	}

	haml :index
	
end

require 'thor'
require 'wpscaffold'

module Wpscaffold
	class CLI < Thor
		desc "portray ITEM", "Determines if a piece of food is gross or delicious"
		def portray(name)
			puts Wpscaffold::Food.portray(name)
		end
	end
end
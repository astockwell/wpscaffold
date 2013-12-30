require 'wpscaffold'

require 'wpscaffold/ACF'

module Wpscaffold
	class Controller
		def self.portray(food)
			if food.downcase == "broccoli"
				"Gross!"
			else
				"Delicious!"
			end
		end
	end
end
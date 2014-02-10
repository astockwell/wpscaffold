require 'wpscaffold'

require 'wpscaffold/ACF'
require 'wpscaffold/Builder'
require 'wpscaffold/Core'
require 'wpscaffold/xml_writer'

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
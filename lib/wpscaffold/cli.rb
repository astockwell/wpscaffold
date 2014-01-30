require 'thor'
require 'wpscaffold'

module Wpscaffold
	class CLI < Thor
		desc "portray ITEM", "Determines if a piece of food is gross or delicious"
		def portray(name)
			puts Wpscaffold::Controller.portray(name)
		end

		# desc "field parsing logic"
		# def parse_field(raw)
		# 	parts = raw.split(":")
		# 	raise ArgumentError, "No fieldtype for (#{raw}) specified." unless parts.length > 1
		# 	@fieldlist.fields << field_factory(parts[0], parts[1], index, parts[2, parts.size], options.select { |k,v| k =~ /#{parts[0]}/ })
		# end
	end
end
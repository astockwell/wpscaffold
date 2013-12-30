require 'wpscaffold'

module Wpscaffold
	module ACF
		class FieldGroup
			FieldList = Struct.new(:fields, :parent_field, :parent_fieldlist)

			def initialize(*args, &block)
			end
		end
	end
end
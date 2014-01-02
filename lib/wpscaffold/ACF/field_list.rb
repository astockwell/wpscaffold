require 'wpscaffold'

module Wpscaffold
	module ACF
		class FieldList
			attr_reader :fields, :parent_field, :parent_fieldlist, :options

			def initialize(fields=[], parent_field=nil, parent_fieldlist=nil, options={})
				@fields, @parent_field, @parent_fieldlist, @options = fields, parent_field, parent_fieldlist, options
			end
		end
	end
end
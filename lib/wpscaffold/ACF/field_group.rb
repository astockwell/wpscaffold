require 'wpscaffold'

module Wpscaffold
	module ACF
		class FieldGroup
			attr_accessor :title, :fields

			def initialize(field_group_subject, fields=[], options={})
				@title, @fields = field_group_subject, fields
			end
		end
	end
end
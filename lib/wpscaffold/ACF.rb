require 'wpscaffold'

require 'wpscaffold/ACF/field_group'
require 'wpscaffold/ACF/field_list'
require 'wpscaffold/ACF/fields/field'
require 'wpscaffold/ACF/fields/text_field'
# modifier signature:
require 'wpscaffold/ACF/fields/image_field'
# modifier signature: [image_size]
require 'wpscaffold/ACF/fields/repeater_field'
# modifier signature:

module Wpscaffold
	module ACF
		# EACHERATOR = "_each"
		# OBJECTERATOR = "_object"

		class << self

			# Create instances of correct fieldtypes
			def create_field(field_name, field_type, order_no, parent_field=nil, modifiers=[], options={})
				field_class_name = "#{field_type.to_s.capitalize}Field"
				raise ArgumentError, "No fieldtype (#{field_class_name}) for (#{field_name}) exists or is defined." unless field_class = field_type_exists?(field_class_name)
				# todo: modifiers array should be removed, it is UI specific, and modifiers should be passed as options and handled thusly by individual fieldtypes
				field_class.new(field_name, order_no, parent_field, modifiers, options)
			end

			# private

			# Safely get fieldtype's class from user input
			def field_type_exists?(field_type)
				klass = ACF.const_get(field_type)
				return klass.is_a?(Class) ? klass : false
			rescue NameError
				return false
			end

		end
	end
end
require 'wpscaffold'

module Wpscaffold
	module ACF
		class FieldGroup
			attr_reader :title, :fieldlist

			def initialize(field_group_subject, fields=[], options={})
				@title = field_group_subject
				@fieldlist = FieldList.new

				fields.each_with_index do |field, index|
					# todo: move this split/parse logic to UI, fields should be specified in proper array syntax, possibly w/ class already determined
					parts = field.split(":")
					raise ArgumentError, "No fieldtype for (#{field}) specified." unless parts.length > 1
					@fieldlist.fields << field_factory(parts[0], parts[1], index, parts[2, parts.size], options.select { |k,v| k =~ /#{parts[0]}/ })
				end

			end

			# Create instances of correct fieldtypes
			def field_factory(field_name, field_type, order_no, modifiers=[], options={})
				field_class_name = "#{field_type.to_s.capitalize}Field"
				raise ArgumentError, "No fieldtype (#{field_class}) for (#{field_name}) exists or is defined." unless field_class = field_type_exists?(field_class_name)
				# todo: modifiers array should be removed, it is UI specific, and modifiers should be passed as options and handled thusly by individual fieldtypes
				field_class.new(field_name, order_no, modifiers, options)
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
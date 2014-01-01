require 'wpscaffold'

module Wpscaffold
	module ACF
		class FieldGroup
			FieldList = Struct.new(:fields, :parent_field, :parent_fieldlist)
			attr_reader :title, :fieldlist

			def initialize(field_group_subject, fields=[], options={})
				@title = field_group_subject
				@fieldlist = FieldList.new(fields: [])

				fields.each do |field|
					parts = field.split(":")
					raise ArgumentError, "No fieldtype for (#{field}) specified." unless parts.length > 1
					@fieldlist.fields << field_factory(parts[0], parts[1], parts[2, parts.size], options.select { |k,v| k =~ /#{parts[0]}/ })
				end

			end

			def field_factory(field_name, field_type, modifiers=[], options={})
				field_class_name = "#{field_type.to_s.capitalize}Field"

				unless field_class = field_type_exists?(field_class_name)
					raise ArgumentError, "No fieldtype (#{field_class}) for (#{field_name}) exists or is defined."
				end
				options[:prehooks] = field_class.prehooks
				field_class.new(field_name, modifiers, options)
			end

			# private

			def field_type_exists?(field_type)
				klass = ACF.const_get(field_type)
				return klass.is_a?(Class) ? klass : false
			rescue NameError
				return false
			end
		end
	end
end
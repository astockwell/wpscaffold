require 'rubygems'
require 'highline/import'

require 'wpscaffold'

module Wpscaffold
	module ACF
		class Field
			attr_accessor :options

			def initialize(raw_field, options = {}, &block)
				@options = options
				parts = raw_field.split(":")

				unless parts.length > 1
					raise ArgumentError, "No fieldtype for (#{raw_field}) specified."
				end

				@type = "#{parts[1].camelize}Field"

				unless field_exists?(@type)
					raise ArgumentError, "No fieldtype (#{@type}) for (#{raw_field}) exists or is defined."
				end

			end

			def to_php
				raise NotImplementedError
			end

			def to_xml
				raise NotImplementedError
			end

			private

			def field_exists?(field_type)
				klass = ACF.const_get(field_type)
				return klass.is_a?(Class)
			rescue NameError
				return false
			end
		end
	end
end
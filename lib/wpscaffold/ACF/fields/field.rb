require 'wpscaffold'

module Wpscaffold
	module ACF
		class Field
			attr_accessor :options

			def initialize(options={}, &block)
				@options = options
			end

			# Subclasses must provide an implementation of this method.
			def to_php
				raise NotImplementedError
			end

			# Subclasses must provide an implementation of this method.
			def to_xml
				raise NotImplementedError
			end
		end
	end
end
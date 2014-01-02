require 'rubygems'
require 'highline/import'
require 'uuid'

require 'wpscaffold'

module Wpscaffold
	module ACF
		class Field
			attr_accessor :label, :name, :order_no, :key, :options

			# class << self
			# 	def prehooks
			# 		# actions to perform before field is
			# 		# instantiated, e.g. ask for child fields
			# 	end
			# end

			def initialize(raw_field_name, order_no, modifiers=[], options={})
				@label    = raw_field_name.titleize
				@name     = raw_field_name.parameterize.underscore
				@order_no = order_no
				@key      = keygen
				@options  = options

				# Internal
				@raw = raw_field_name
				@modifiers = modifiers

				handle_modifiers
			end

			def to_php
				raise NotImplementedError
			end

			def to_xml
				raise NotImplementedError
			end

			private

			# Generate unique field key
			def default_xml
				{
					"key"          => @key,
					"label"        => @label,
					"name"         => @name,
					"type"         => self.class.to_s.split('::').last.gsub(/Field/, '').downcase,
					"order_no"     => @order_no,
					"instructions" => @options[:instructions] || "",
					"required"     => @options[:required]     || "0",
					"conditional_logic" => @options[:conditional_logic] || {
						"status" => "0",
						"rules"  => [
							{
								"field"    => "null",
								"operator" => "==",
								"value"    => ""
							}
						],
						"allorany" => "all"
					},
				}
			end

			def eacherator
				"_each"
			end

			def get_field
				"get_field(\"#{@name}\")"
			end

			def keygen
				uuid = UUID.new
				"field_" + uuid.generate.gsub(/-/,'')[0..12]
			end

			def objecterator
				"_object"
			end

			def php_variable
				"$#{@name}"
			end

			def handle_modifiers
				# implement way to adjust @options via modifiers
				# maybe this is just another overridable method
			end
		end
	end
end
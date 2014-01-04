require 'rubygems'
require 'highline/import'
require 'uuid'

require 'wpscaffold'

module Wpscaffold
	module ACF
		class Field
			attr_accessor :label, :name, :order_no, :parent, :options, :key

			def initialize(raw_field_name, order_no, parent=nil, modifiers=[], options={})
				@label     = raw_field_name.titleize
				@name      = raw_field_name.parameterize.underscore
				@order_no  = order_no
				@parent    = parent
				@key       = keygen

				# Internal
				@raw       = raw_field_name
				@modifiers = modifiers
				@options   = options

				# Bootstrap, save a lot of error checking
				@options[:xml] = {} unless @options[:xml]
				# handle_modifiers
			end

			def to_php
				raise NotImplementedError
			end

			def to_xml
				raise NotImplementedError
			end

			private

			def default_xml
				{
					"key"          => @key,
					"label"        => @label,
					"name"         => @name,
					"type"         => self.class.to_s.split('::').last.gsub(/Field/, '').downcase,
					"order_no"     => @order_no,
					"instructions" => @options[:xml][:instructions] || "",
					"required"     => @options[:xml][:required]     || "0",
					"conditional_logic" => @options[:xml][:conditional_logic] || {
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

			# def merge_xml_options
			# 	@xml = @xml || default_xml
			# 	@xml.merge! @options[:xml]
			# end

			def objecterator
				"_object"
			end

			def php_variable
				"$#{@name}"
			end

			# def handle_modifiers
			# 	# implement way to adjust @options via modifiers
			# 	# maybe this is just another overridable method
			# end
		end
	end
end
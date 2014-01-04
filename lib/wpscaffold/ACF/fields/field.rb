require 'rubygems'
require 'highline/import'
require 'uuid'

require 'wpscaffold'

module Wpscaffold
	module ACF
		class Field
			attr_accessor :label, :name, :order_no, :options, :key

			def initialize(raw_field_name, order_no, options={})
				@label     = raw_field_name.titleize
				@name      = raw_field_name.parameterize.underscore
				@order_no  = order_no
				@key       = keygen

				# Internal
				@raw       = raw_field_name
				@options   = options

				# Bootstrap, save a lot of error checking
				@options[:xml] = {} unless @options[:xml]
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
				"__fields__"
			end

			def get_field(format=nil)
				if format == :erb
					return '<%= get_field %>'
				else
					"get_field(\"#{@name}\")"
				end
			end

			def keygen
				uuid = UUID.new
				"field_" + uuid.generate.gsub(/-/,'')[0..12]
			end

			def objecterator
				"__object__"
			end

			def php_variable(format=nil)
				if format == :erb
					return '<%= php_variable %>'
				else
					"$#{@name}"
				end
			end
		end
	end
end
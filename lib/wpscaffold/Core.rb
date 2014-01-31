require 'wpscaffold'

require 'wpscaffold/Core/template/base'
require 'wpscaffold/Core/template/archive'
require 'wpscaffold/Core/template/sass'
require 'wpscaffold/Core/template/single'
require 'wpscaffold/Core/template/static'
require 'wpscaffold/Core/template/cpt'

module Wpscaffold
	module Core
		class << self
			# Create instances of correct template
			def create_template(template_type, template_name, options={})
				template_class_name = "#{template_type.to_s}"
				raise ArgumentError, "No template (#{template_class_name}) for (#{template_name}) exists or is defined." unless template_class = template_type_exists?(template_class_name)
				template_class.new(template_name, options)
			end

			private

			# Safely get template's class from user input
			def template_type_exists?(template_type)
				klass = Core::Template.const_get(template_type)
				return klass.is_a?(Class) ? klass : false
			rescue NameError
				return false
			end
		end
	end
end
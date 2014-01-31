require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Sass < Base
				# Creates a template .scss file to complement any php file's template
				# Params:
				# - [name]* the exact name of the class that should go on the body tag (required)
				# - [@options[:filepath]]* the destination filepath (required)
				# - [@options[:filename]]* the destination filename (required)

				def css_class
					false
				end

				def filename
					"#{@options[:filepath]}/#{@options[:filename]}.scss"
				end

				alias_method :to_scss, :to_php
				def to_php
					Tilt.new("#{erb_path}/#{class_name}.scss.erb").render(self)
				end

				def to_xml
					false
				end
			end
		end
	end
end
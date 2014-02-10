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

				def filename
					# "#{@options[:filepath]}/_#{@options[:filename]}.scss"
					# "#{@name}.scss"
					File.join("sass", @name)
				end

				def inserts
					[
						{
							filename: File.join( "sass", "screen.scss"),
							contents: "@import \"#{@name}\";"
						}
					]
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
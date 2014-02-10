require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Archive < Base
				def css_class
					"post-type-archive-#{@title[:underscore]}"
				end

				def css_filename
					File.join("archive", "_#{@title[:underscore]}.scss")
				end

				def filename
					"archive-#{@title[:underscore]}.php"
				end

				def to_php
					@fields = prepare_template_fields
					Tilt.new("#{erb_path}/#{class_name}.php.erb").render(self)
				end

				def to_xml
					false
				end
			end
		end
	end
end
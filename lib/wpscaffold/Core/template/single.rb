require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Single < Base
				def css_class
					"single-#{@title[:underscore]}"
				end

				def css_filename
					File.join("single", "_#{@title[:underscore]}.scss")
				end

				def filename
					"single-#{@title[:underscore]}.php"
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
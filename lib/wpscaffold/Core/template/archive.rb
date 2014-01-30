require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Archive < Base
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
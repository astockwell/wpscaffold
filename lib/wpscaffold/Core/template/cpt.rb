require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class CPT < Base
				def css_class
					false
				end

				def filename
					"#{@title[:underscore]}.php"
				end

				def to_php
					Tilt.new("#{erb_path}/#{class_name}.php.erb").render(self)
				end

				def to_xml
					false
				end
			end
		end
	end
end
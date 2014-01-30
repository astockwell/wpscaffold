require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Base
				attr_accessor :name, :options

				def initialize(name, options={})
					@name    = name
					@options = options
				end

				def filename
					raise NotImplementedError
				end

				def to_file
					{
						filename: filename,
						contents: to_php,
					}
				end

				def to_php
					raise NotImplementedError
				end

				def to_xml
					raise NotImplementedError
				end

				private

				def class_name
					self.class.name.split('::').last
				end

				def default_post_fields
					"<h1><?php the_title(); ?></h1>\n<?php the_content(); ?>\n"
				end

				def erb_path
					"lib/wpscaffold/Core/template/erb"
				end
			end
		end
	end
end
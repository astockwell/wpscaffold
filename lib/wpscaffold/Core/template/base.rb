require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Base
				attr_accessor :title, :slug

				def initialize(page_name, options={})
					@title   = page_name.titleize
					@slug    = page_name.parameterize.underscore

					# Internal
					@options = options
					@raw     = page_name
				end

				def filename
					raise NotImplementedError
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
require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Base
				attr_accessor :name, :options, :title

				def initialize(name, options={})
					@name, @options = name, options
					@title = {
						titleized:  @name.titleize,
						singular:   @name.titleize.singularize,
						plural:     @name.titleize.pluralize,
						slug:       @name.singularize.parameterize,
						underscore: @name.singularize.parameterize.underscore,
					}
				end

				def css_class
					false
				end

				def filename
					raise NotImplementedError
				end

				def inserts
					false
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
					File.join(File.dirname(__FILE__), "erb")
				end

				def prepare_template_fields
					@options[:field_group] && @options[:field_group].to_php + "\n" || default_post_fields
				end
			end
		end
	end
end
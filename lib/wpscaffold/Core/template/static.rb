require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Static < Base
				def initialize(name, options={})
					super
					@title = @name.titleize
					@slug  = @name.parameterize
				end

				def filename
					"page-#{@slug}.php"
				end

				def to_php
					@fields = @options[:fields] && @options[:fields].to_php + "\n" || default_post_fields
					Tilt.new("#{erb_path}/#{class_name}.php.erb").render(self)
				end

				def to_xml
					{
						title:     @title,
						post_name: @slug,
						post_type: @options[:post_type] || "page",
						post_id:   @options[:post_id]   || nil,
						content:   @options[:content]   || nil,
						excerpt:   @options[:excerpt]   || nil,
						postmeta:  [
							{
								:'wp:meta_key'    => '_wp_page_template',
								:'wp:meta_value!' => @options[:postmeta] && @options[:postmeta][:_wp_page_template] && "<![CDATA[#{@options[:postmeta][:_wp_page_template]}]]>" || '<![CDATA[default]]>',
							},
						],
					}
				end
			end
		end
	end
end
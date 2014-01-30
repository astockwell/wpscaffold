require 'wpscaffold'

module Wpscaffold
	module Core
		module Template
			class Static < Base
				def filename
					"page-#{@title[:slug]}.php"
				end

				def to_php
					@fields = prepare_template_fields
					Tilt.new("#{erb_path}/#{class_name}.php.erb").render(self)
				end

				def to_xml
					{
						title:     @title[:titleized],
						post_name: @title[:slug],
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
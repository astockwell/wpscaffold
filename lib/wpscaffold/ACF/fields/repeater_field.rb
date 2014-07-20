require 'rubygems'
require 'tilt'

require 'wpscaffold'

module Wpscaffold
	module ACF
		class RepeaterField < Field
			def to_php(format=nil)
%Q[<?php #{php_variable(format)} = #{get_field(format)}; if ( !empty(#{php_variable(format)}) ): ?>
	<?php foreach(#{php_variable(format)} as #{php_variable(format)}#{eacherator}): ?>

#{child_fields_to_php}
	<?php endforeach; ?>
<?php endif; ?>]
			end
			def to_xml
				default_xml.merge({
					:sub_fields   => child_fields_to_xml           || nil,
					:row_min      => @options[:xml][:row_min]      || "0",
					:row_limit    => @options[:xml][:row_limit]    || "",
					:layout       => @options[:xml][:layout]       || "table",
					:button_label => @options[:xml][:button_label] || "Add Row",
				})
			end

			private

			def child_fields_to_xml
				xml_output = []
				children = *@options[:child_fields]
				children.each do |f|
					xml_output << f.to_xml
					xml_output.last.delete(:conditional_logic)
				end
				xml_output
			end

			def child_fields_to_php
				php_output = ''
				children = *@options[:child_fields]
				children.each do |f|
					repeater_get_field = "$#{@name}#{eacherator}[\"#{f.name}\"]"
					template = Tilt['erb'].new { f.to_php(:erb) }
					rendered = template.render(f, get_field: repeater_get_field)
					indented = rendered.gsub(/^/) { |match| "\t\t" }
					php_output += indented + "\n"
				end
				php_output
			end
		end

		# Alias the class
		RField = RepeaterField
	end
end
require 'wpscaffold'

module Wpscaffold
	module ACF
		class RepeaterField < Field
			def to_php
%Q[<?php #{php_variable} = #{get_field}; if (#{php_variable}): ?>
	<?php foreach(#{php_variable} as #{php_variable}#{eacherator}): ?>

#{@child_fields}
	<?php endforeach; ?>
<?php endif; ?>]
			end
			def to_xml
				default_xml.merge({
					# "sub_fields" => [
					# 	{
					# 		"key" => "field_527c0c8578be9",
					# 		"label" => "Position Title",
					# 		"name" => "position_title",
					# 		"type" => "text",
					# 		"instructions" => "",
					# 		"column_width" => "",
					# 		"default_value" => "",
					# 		"placeholder" => "",
					# 		"prepend" => "",
					# 		"append" => "",
					# 		"formatting" => "html",
					# 		"maxlength" => "",
					# 		"order_no" => 0
					# 	},
					# 	{
					# 		"key" => "field_527c0c9378bea",
					# 		"label" => "Position Details",
					# 		"name" => "position_details",
					# 		"type" => "wysiwyg",
					# 		"instructions" => "",
					# 		"column_width" => "",
					# 		"default_value" => "",
					# 		"toolbar" => "basic",
					# 		"media_upload" => "no",
					# 		"order_no" => 1
					# 	}
					# ],
					"row_min"      => @options[:row_min]      || "0",
					"row_limit"    => @options[:row_limit]    || "",
					"layout"       => @options[:layout]       || "table",
					"button_label" => @options[:button_label] || "Add Row",
				})
			end
		end

		# Alias the class
		RField = RepeaterField
	end
end
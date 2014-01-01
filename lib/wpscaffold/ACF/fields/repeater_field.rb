require 'wpscaffold'

module Wpscaffold
	module ACF
		class RepeaterField < Field

			def get_field_info
				ask("\nWhat are the child fields for #{@raw}? ", Array)
			end

			def to_php
				%q[<?php <%= variable %> = <%= get_field %>; if (<%= variable %>): ?>
	<?php foreach(<%= variable %> as <%= variable + EACHERATOR %>): ?>

<%= children %>
	<?php endforeach; ?>
<?php endif; ?>]
			end

			def to_xml
				{
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
					"row_min"           => "0",
					"row_limit"         => "",
					"layout"            => "table",
					"button_label"      => "Add Row",
				}
			end
		end
	end
end
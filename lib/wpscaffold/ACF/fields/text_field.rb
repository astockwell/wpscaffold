require 'wpscaffold'

module Wpscaffold
	module ACF
		class TextField < Field
			def to_php
%Q[<?php #{php_variable} = #{get_field}; if (#{php_variable}): ?>
	<?php echo #{php_variable}; ?>
<?php endif; ?>]
			end
			def to_xml
				default_xml.merge({
					"default_value" => @options[:default_value] || "",
					"placeholder"   => @options[:placeholder]   || "",
					"prepend"       => @options[:prepend]       || "",
					"append"        => @options[:append]        || "",
					"formatting"    => @options[:formatting]    || "html", # html || none
					"maxlength"     => @options[:maxlength]     || "",
					"conditional_logic" => @options[:conditional_logic] || {
						"status" => "0",
						"rules"  => [
							{
								"field"    => "null",
								"operator" => "==",
								"value"    => ""
							}
						],
						"allorany" => "all"
					},
				})
			end
		end

		# Alias the class
		TField = TextField
	end
end
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
					"default_value" => @options[:xml][:default_value] || "",
					"placeholder"   => @options[:xml][:placeholder]   || "",
					"prepend"       => @options[:xml][:prepend]       || "",
					"append"        => @options[:xml][:append]        || "",
					"formatting"    => @options[:xml][:formatting]    || "html", # html || none
					"maxlength"     => @options[:xml][:maxlength]     || "",
				})
			end
		end

		# Alias the class
		TField = TextField
	end
end
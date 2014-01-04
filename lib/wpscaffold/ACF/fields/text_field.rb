require 'wpscaffold'

module Wpscaffold
	module ACF
		class TextField < Field
			def to_php(format=nil)
%Q[<?php #{php_variable(format)} = #{get_field(format)}; if (#{php_variable(format)}): ?>
	<?php echo #{php_variable(format)}; ?>
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
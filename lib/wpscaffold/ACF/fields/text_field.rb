require 'wpscaffold'

module Wpscaffold
	module ACF
		class TextField < Field
			class << self
				def prehooks
					"prehooks!"
				end
			end

			def to_php
				%q[<?php <%= variable %> = <%= get_field %>; if (<%= variable %>): ?>
	<?php echo <%= variable %>; ?>
<?php endif; ?>]
			end
			def to_xml
				{
					"default_value" => @options[:default_value] || "",
					"placeholder"   => @options[:placeholder]   || "",
					"prepend"       => @options[:prepend]       || "",
					"append"        => @options[:append]        || "",
					"formatting"    => @options[:formatting]    || "html", # html || none
					"maxlength"     => @options[:maxlength]     || "",
				}
			end
		end

		# Alias the class
		TField = TextField
	end
end
require 'wpscaffold'

module Wpscaffold
	module ACF
		class ImageField < Field
			def handle_modifiers
				@image_size = '["url"]'
				if @modifiers.size > 0
					@image_size = "[\"sizes\"][\"#{@modifiers.first}\"]"
				end
			end
			def to_php
%Q[<?php #{php_variable} = #{get_field}; if (#{php_variable}): ?>
	<img src="<?php echo #{php_variable}#{@image_size}; ?>" alt="<?php echo #{php_variable}["alt"]; ?>" title="<?php echo #{php_variable}["title"]; ?>" />
<?php endif; ?>]
			end
			def to_xml
				default_xml.merge({
					"save_format"  => @options[:save_format]  || "object",
					"preview_size" => @options[:preview_size] || "thumbnail",
					"library"      => @options[:library]      || "all",
				})
			end
		end

		# Alias the class
		IField = ImageField
	end
end
require 'wpscaffold'

module Wpscaffold
	module ACF
		class ImageField < Field
			def to_php(format=nil)
%Q[<?php #{php_variable(format)} = #{get_field(format)}; if (#{php_variable(format)}): ?>
	<img src="<?php echo #{php_variable(format)}#{image_size}; ?>" alt="<?php echo #{php_variable(format)}["alt"]; ?>" title="<?php echo #{php_variable(format)}["title"]; ?>" />
<?php endif; ?>]
			end
			def to_xml
				default_xml.merge({
					:save_format  => @options[:xml][:save_format]  || "object",
					:preview_size => @options[:xml][:preview_size] || "thumbnail",
					:library      => @options[:xml][:library]      || "all",
				})
			end

			private

			def image_size
				if @options[:image_size]
					return "[\"sizes\"][\"#{@options[:image_size]}\"]"
				else
					return '["url"]'
				end
			end
		end

		# Alias the class
		IField = ImageField
	end
end
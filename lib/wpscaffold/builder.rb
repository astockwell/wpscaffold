require 'wpscaffold'

module Wpscaffold
	class Builder
		def self.field_group(field_group_subject, fields=[], options={})
			Wpscaffold::ACF::FieldGroup.new( field_group_subject, fields, options )
		end

		def self.field(field_type, field_name, order_no, options={})
			Wpscaffold::ACF.create_field( field_type, field_name, order_no, options )
		end

		def self.template(template_type, template_name, options={})
			Wpscaffold::Core.create_template( template_type, template_name, options )
		end
	end
end
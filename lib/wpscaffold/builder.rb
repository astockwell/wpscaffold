require 'wpscaffold'

module Wpscaffold
	class Builder
		WPROOT = File.join(root, "wp")
		def self.cpt(name, field_group=nil, options={})

			# Build ACF fields php -> handle @ cli class
			# Build ACF fieldgroup xml -> handle @ cli class

			files = []

			acf_xml             = field_group.to_xml

			cpt_php             = self.template(:CPT, name, field_group: field_group)
			archive_php         = self.template(:Archive, name, field_group: field_group)
			archive_scss        = self.template(:Sass, archive_php.css_filename)
			single_php          = self.template(:Single, name, field_group: field_group)
			single_scss         = self.template(:Sass, single_php.css_filename)
			archive_static_page = self.template(:Static, name, field_group: field_group)

			objects = [ cpt_php, archive_php, archive_scss, single_php, single_scss, archive_static_page ]

			files << { filename: File.join(WPROOT, acf_xml[:post_name], contents: acf_xml }

			files << { filename: File.join(WPROOT, cpt_php.filename, contents: cpt_php.to_php }
			files << { filename: File.join(WPROOT, archive_php.filename , contents: archive_php.to_php }
			files << { filename: File.join(WPROOT, archive_scss.filename , contents: archive_scss.to_php }
			files << { filename: File.join(WPROOT, single_php.filename , contents: single_php.to_php }
			files << { filename: File.join(WPROOT, single_scss.filename , contents: single_scss.to_php }
			files << { filename: File.join(WPROOT, archive_static_page.filename , contents: archive_static_page.to_php }

			# objects = {
			# 	# Build cpt register php
			# 	:cpt_php             => self.template(:Cpt, name, field_group: field_group),

			# 	# Build cpt archive php
			# 	:archive_php         => self.template(:Archive, name, field_group: field_group),

			# 	# Build cpt archive scss
			# 	:archive_scss        => self.template(:Sass, archive_php.css_class),

			# 	# Build cpt single php
			# 	:single_php          => self.template(:Archive, name, field_group: field_group),

			# 	# Build cpt single scss
			# 	:single_scss         => self.template(:Sass, single_php.css_class),

			# 	# Build cpt archive static page xml
			# 	:archive_static_page => self.template(:Static, name, field_group: field_group),
			# }

			# Build list of inserts to files
			inserts = objects.each { |o| o.inserts }

			output = {
				files: files,
				inserts: inserts
			}

			output[:files].each do |filename, contents|
				File.open filename, "w" do |file|
				    file.write contents
				    puts "Wrote file #{filename}"
				end
			end
		end

		def self.field_group(field_group_subject, fields=[], options={})
			Wpscaffold::ACF::FieldGroup.new( field_group_subject, fields, options )
		end

		def self.field(field_name, field_type, order_no, options={})
			Wpscaffold::ACF.create_field( field_name, field_type, order_no, options )
		end

		def self.template(template_type, template_name, options={})
			Wpscaffold::Core.create_template( template_type, template_name, options )
		end
	end
end
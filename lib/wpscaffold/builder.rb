require 'wpscaffold'

module Wpscaffold
	class Builder
		WPROOT = File.join(Dir.pwd, "wp")
		def self.cpt(name, field_group=nil, options={})

			# Build ACF fields php -> handle @ cli class
			# Build ACF fieldgroup xml -> handle @ cli class

			files = []

			cpt_php             = self.template(:CPT, name, field_group: field_group)
			archive_php         = self.template(:Archive, name, field_group: field_group)
			archive_scss        = self.template(:Sass, archive_php.css_filename)
			single_php          = self.template(:Single, name, field_group: field_group)
			single_scss         = self.template(:Sass, single_php.css_filename)
			# archive_static_page = self.template(:Static, name, field_group: field_group)

			objects = [ cpt_php, archive_php, archive_scss, single_php, single_scss ]

			# Build cpt register php
			files << { filename: cpt_php.filename, contents: cpt_php.to_php }
			# Build cpt archive php
			files << { filename: archive_php.filename, contents: archive_php.to_php }
			# Build cpt archive scss
			files << { filename: archive_scss.filename, contents: archive_scss.to_php }
			# Build cpt single php
			files << { filename: single_php.filename, contents: single_php.to_php }
			# Build cpt single scss
			files << { filename: single_scss.filename, contents: single_scss.to_php }
			# Build cpt archive static page xml
			# files << { filename: archive_static_page.filename, contents: archive_static_page.to_php }

			# Build list of inserts to files
			inserts = []
			objects.each do |o|
				if o.inserts
					inserts << o.inserts
				end
			end

			xml_writer = Wpscaffold::XmlWriter.new([field_group])

			files << { filename: "import-for-#{name}.xml", contents: xml_writer.render }

			output = {
				files: files,
				inserts: inserts
			}

			self.write_files(files.flatten)
			self.append_files(inserts.flatten)

			return output
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

		def self.append_files(files, options={})
			files.each do |f|
				File.open(File.join(WPROOT, f[:filename]), 'a') do |file|
					file.write("\n#{f[:contents]}")
				end
			end
		end

		def self.write_files(files, options={})
			files.each do |f|
				File.open(File.join(WPROOT, f[:filename]), 'w') do |file|
				    file.write(f[:contents])
				end
			end
		end
	end
end
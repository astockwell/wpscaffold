require 'thor'
require 'wpscaffold'

module Wpscaffold
	class CLI < Thor
		desc "fields FIELDS...", "Output markup for 1..n fields"
		def fields(*fields)
			field_objects = parse_cli_fields(fields)
			field_objects.each do |f|
				puts f.to_php
			end
		end

		desc "cpt POST_TYPE FIELDS... [FLAGS...]", "Generates files for a CPT"
		def cpt(name, *fields)
			field_group = fields.size > 0 && Wpscaffold::Builder.field_group( "CPT: #{name.titleize}", parse_cli_fields(fields) ) || nil

			files = []

			cpt_php      = Wpscaffold::Builder.template(:CPT, name, field_group: field_group)
			archive_php  = Wpscaffold::Builder.template(:Archive, name, field_group: field_group)
			archive_scss = Wpscaffold::Builder.template(:Sass, archive_php.css_filename)
			single_php   = Wpscaffold::Builder.template(:Single, name, field_group: field_group)
			single_scss  = Wpscaffold::Builder.template(:Sass, single_php.css_filename)
			# archive_static_page = Wpscaffold::Builder.template(:Static, name, field_group: field_group)

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

			if field_group
				xml_writer = Wpscaffold::XmlWriter.new([field_group])
				files << { filename: "import-for-#{name}.xml", contents: xml_writer.render }
			end

			write_files(files.flatten)
			append_files(inserts.flatten)

			say("CPT #{name} was scaffolded successfully", :green)
			# say("An error occurred, CPT #{name} was not scaffolded successfully", :red)
		end

		private

		WPROOT = File.join(Dir.pwd, "wp")

		FIELD_MAP = {
			# "gallery"      => :gallery,
			# "g"            => :gallery,
			"image"        => :image,
			"i"            => :image,
			# "relationship" => :relationship,
			# "rel"          => :relationship,
			"repeater"     => :repeater,
			"rep"          => :repeater,
			"r"            => :repeater,
			"text"         => :text,
			"t"            => :text,
			# "textarea"     => :textarea,
			# "ta"           => :textarea,
			# "wysiwyg"      => :wysiwyg,
			# "w"            => :wysiwyg,
		}

		def field_specific_options(parts, klass, options)
			if klass == :repeater
				# children = ask("What are the child fields for #{parts.join(':')}?", :blue)
				# parsed_fields = parse_cli_fields(children.split)
				# options[:child_fields] = parsed_fields
				options[:child_fields] = parse_cli_fields( ask("What are the child fields for #{parts.join(':')}?", :blue).split )
			end

			options
		end

		def parse_cli_fields(fields, options={})
			field_objects = []
			fields.each_with_index do |field, index|
				parts = field.split(":")
				unless parts.size > 1
					# raise ArgumentError, "You did not properly specify a field_type for #{field}, please use the syntax `field_name:field_type:options`"

					# Default to text (string) field if none provided
					parts << 'text'
				end
				begin
					klass = FIELD_MAP[parts[1]]
					field_objects << Wpscaffold::Builder.field( klass, parts[0], index, field_specific_options(parts, klass, options) )
				rescue NoMethodError => e
					puts "The field_type you specified in `#{field}` does not exist"
					puts e
					exit
				end
			end
			field_objects
		end

		def append_files(files, options={})
			files.each do |f|
				File.open(File.join(WPROOT, f[:filename]), 'a') do |file|
					file.write("\n#{f[:contents]}")
				end
				say_status("update", f[:filename], :yellow)
			end
		end

		def write_files(files, options={})
			files.each do |f|
				File.open(File.join(WPROOT, f[:filename]), 'w') do |file|
				    file.write(f[:contents])
				end
				say_status("create", f[:filename], :green)
			end
		end
	end
end
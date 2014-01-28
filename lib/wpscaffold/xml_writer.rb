require 'wpscaffold'

module Wpscaffold
	class XmlWriter

		# Accepts objects that implement #to_xml
		def initialize(args)

		end

		def defaults
			post_date = Time.new
			item_obj = {
				'title!'            => "<![CDATA[#{options[:title]}]]>",
				'pubDate'           => post_date.gmtime.strftime("%a, %d %b %Y %H:%M:%S %z"),
				'wp:post_date'      => post_date.localtime.strftime("%Y-%m-%d %H:%M:%S"),
				'wp:post_date_gmt'  => post_date.gmtime.strftime("%Y-%m-%d %H:%M:%S"),
				'wp:comment_status' => options[:comment_status] ? options[:comment_status] : 'closed',
				'wp:ping_status'    => options[:ping_status] ? options[:ping_status] : 'closed',
				'wp:post_name'      => options[:post_name] ? options[:post_name] : options[:title].parameterize,
				'wp:status'         => options[:status] ? options[:status] : 'publish',
				'wp:post_type'      => options[:post_type],
			}
			item_obj['wp:post_id']  = options[:post_id] if options[:post_id]
			item_obj['content:encoded!']  = options[:content] if options[:content]
			item_obj['excerpt:encoded!']  = options[:excerpt] if options[:excerpt]
			item_obj['wp:postmeta'] = options[:postmeta] if options[:postmeta]

			item_obj
		end

		# Compiles XML output for import into wordpress
		def render
			creation_time = Time.new
			xml_header = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<!-- generator=\"WordPress/3.7.1\" created=\"#{creation_time.gmtime.strftime("%Y-%m-%d %H:%M:%S")}\" -->\n"
			xml_skel = {
				"rss" => {
					"channel" => {
						"pubDate"        => creation_time.gmtime.strftime("%a, %d %b %Y %H:%M:%S %z"),
						"wp:wxr_version" => "1.1",
						"item"           => @items
					},
					"@version"       => "2.0",
					"@xmlns:excerpt" => "http://wordpress.org/export/1.1/excerpt/",
					"@xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
					"@xmlns:wfw"     => "http://wellformedweb.org/CommentAPI/",
					"@xmlns:dc"      => "http://purl.org/dc/elements/1.1/",
					"@xmlns:wp"      => "http://wordpress.org/export/1.1/"
				}
			}

			xml_header + Gyoku.xml(xml_skel)
		end
	end
end
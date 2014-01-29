require 'wpscaffold'
require 'gyoku'

module Wpscaffold
	class XmlWriter
		attr_accessor :items

		# Accepts item(s) that implement #to_xml
		def initialize(items=[], options={})
			@items, @options = items, options
		end

		# Compiles XML output for import into wordpress
		def render
			creation_time = @options[:post_date] || Time.new
			xml_header = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<!-- generator=\"WordPress/3.7.1\" created=\"#{creation_time.gmtime.strftime("%Y-%m-%d %H:%M:%S")}\" -->\n"
			xml_skel = {
				:"rss" => {
					:"channel" => {
						:"pubDate"        => creation_time.gmtime.strftime("%a, %d %b %Y %H:%M:%S %z"),
						:"wp:wxr_version" => "1.1",
						:"item"           => prepare_items
					},
					:"@version"       => "2.0",
					:"@xmlns:excerpt" => "http://wordpress.org/export/1.1/excerpt/",
					:"@xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
					:"@xmlns:wfw"     => "http://wellformedweb.org/CommentAPI/",
					:"@xmlns:dc"      => "http://purl.org/dc/elements/1.1/",
					:"@xmlns:wp"      => "http://wordpress.org/export/1.1/"
				}
			}

			xml_header + Gyoku.xml(xml_skel)
		end

		def prepare_items
			prepared = []
			@items.each do |i|
				prepared << item_skel(i.to_xml)
			end

			prepared
		end

		def item_skel(item)
			post_date = @options[:post_date] || Time.new
			{
				:'title!'            => "<![CDATA[#{item[:title]}]]>",
				:'pubDate'           => post_date.gmtime.strftime("%a, %d %b %Y %H:%M:%S %z"),
				:'wp:post_date'      => post_date.localtime.strftime("%Y-%m-%d %H:%M:%S"),
				:'wp:post_date_gmt'  => post_date.gmtime.strftime("%Y-%m-%d %H:%M:%S"),
				:'content!'          => item[:content] && "<![CDATA[#{item[:content]}]]>" || nil,
				:'excerpt!'          => item[:excerpt] && "<![CDATA[#{item[:excerpt]}]]>" || nil,
				:'wp:comment_status' => item[:comment_status] ? item[:comment_status] : 'closed',
				:'wp:ping_status'    => item[:ping_status] ? item[:ping_status] : 'closed',
				:'wp:status'         => item[:status] ? item[:status] : 'publish',
				:'wp:post_type'      => item[:post_type],
				:'wp:post_name'      => item[:post_name] || nil,
				:'wp:post_id'        => item[:post_id] || nil,
				:'content:encoded!'  => item[:content] || nil,
				:'excerpt:encoded!'  => item[:excerpt] || nil,
				:'wp:postmeta'       => item[:postmeta] || nil
			}
		end
	end
end
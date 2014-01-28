require 'wpscaffold'
require 'php_serialize'

module Wpscaffold
	module ACF
		class FieldGroup
			attr_accessor :title, :fields

			def initialize(field_group_subject, fields=[], options={})
				@title, @fields, @options = field_group_subject, fields, options
			end

			def to_php
				output = ""
				@fields.each_with_index do |field, index|
					output += field.to_php
					output += "\n" unless @fields.size == index + 1
				end
				output
			end

			def to_xml
				field_group_xml_obj = {
					title: @title,
					post_name: "acf_#{@title.parameterize}",
					post_type: "acf",
					postmeta: [
						{
							:'wp:meta_key'    => 'position',
							:'wp:meta_value!' => @options[:position] ? @options[:position] : '<![CDATA[normal]]>',
						},
						{
							:'wp:meta_key'    => 'layout',
							:'wp:meta_value!' => @options[:layout] ? @options[:layout] : '<![CDATA[default]]>',
						},
						{
							:'wp:meta_key'    => 'hide_on_screen',
							:'wp:meta_value!' => @options[:hide_on_screen] ? @options[:hide_on_screen] : '<![CDATA[]]>',
						},
						{
							:'wp:meta_key'    => 'rule',
							:'wp:meta_value!' => '<![CDATA['+ PHP.serialize(rule) +']]>',
						},
					],
				}
				@fields.each_with_index do |field, index|
					field_xml_obj = field.to_xml
					field_xml_obj[:order_no] = index # need to test & refactor
					field_group_xml_obj[:postmeta] << {
						:'wp:meta_key'    => field.key,
						:'wp:meta_value!' => '<![CDATA['+ PHP.serialize(field_xml_obj) +']]>',
					}
				end

				field_group_xml_obj
			end

			def rule
				#
				# POSSIBLE COMBINATIONS:
				# "param" => "post_type" & "value" => "post_type_slug" (for a cpt)
				# "param" => "page" & "value" => $post_id (for a page)
				#
				acf_matching_rule = {}

				acf_matching_rule[:param] = @options[:param] ? @options[:param] : "post_type"
				acf_matching_rule[:value] = @options[:value] ? @options[:value] : "post"

				acf_matching_rule[:operator] = @options[:operator] ? @options[:operator] : "=="
				acf_matching_rule[:order_no] = @options[:order_no] ? @options[:order_no] : 0
				acf_matching_rule[:group_no] = @options[:group_no] ? @options[:group_no] : 0

				acf_matching_rule
			end
		end
	end
end
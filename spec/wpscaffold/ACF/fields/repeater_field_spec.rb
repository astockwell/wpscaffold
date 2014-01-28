require 'spec_helper'
# require 'pp'

describe Wpscaffold::ACF::RepeaterField do
	before :all do
		@text_field1 = Wpscaffold::ACF::TextField.new( "text 1", 0 )
		@text_field2 = Wpscaffold::ACF::TextField.new( "text 2", 1 )
		@text_field3 = Wpscaffold::ACF::TextField.new( "text 3", 2 )
		@image_field1 = Wpscaffold::ACF::ImageField.new( "image 1", 3, image_size: 'custom_size' )

		@sub_repeater_field = Wpscaffold::ACF::RepeaterField.new( "my sub repeater", 0, child_fields: [@text_field1,@text_field2,@text_field3,@image_field1] )

		@repeater_field_with_sub = Wpscaffold::ACF::RepeaterField.new( "my repeater", 0, child_fields: @sub_repeater_field )
		@repeater_field_without_sub = Wpscaffold::ACF::RepeaterField.new( "my repeater", 0, child_fields: [@text_field1,@text_field2,@text_field3,@image_field1] )
		# Test class alias
		@r_field_with_sub = Wpscaffold::ACF::RField.new( "my repeater", 0, child_fields: @sub_repeater_field )
		@r_field_without_sub = Wpscaffold::ACF::RField.new( "my repeater", 0, child_fields: [@text_field1,@text_field2,@text_field3,@image_field1] )
		# Test factory
		@factory_repeater_with_sub = Wpscaffold::ACF.create_field( "my repeater", :repeater, 0, child_fields: @sub_repeater_field )
		@factory_repeater_without_sub = Wpscaffold::ACF.create_field( "my repeater", :repeater, 0, child_fields: [@text_field1,@text_field2,@text_field3,@image_field1] )
		@fields = [
			@repeater_field_without_sub,
			@r_field_without_sub,
			@factory_repeater_without_sub,
			@repeater_field_with_sub,
			@r_field_with_sub,
			@factory_repeater_with_sub,
		]
		@fields_without_sub = @fields[0..@fields.size/2-1]
		@fields_with_sub = @fields[@fields.size/2..-1]
	end

	describe '#new' do
		it "returns an instance of a text ACF field" do
			@fields.each do |f|
				expect(f).to be_an_instance_of Wpscaffold::ACF::RepeaterField
			end
		end
	end
	describe '#to_php' do
		it "returns a template as a string" do
			@fields.each do |f|
				expect(f.to_php).to be_an_instance_of String
			end
		end
		context "without sub-repeaters" do
			it "contains correct eacherators" do
				# puts @repeater_field_without_sub.to_php
				@fields_without_sub.each do |f|
					expect(f.to_php).to include('<?php foreach($my_repeater as $my_repeater__fields__): ?>')
					expect(f.to_php).to include('<?php $text_1 = $my_repeater__fields__["text_1"]; if ($text_1): ?>')
					expect(f.to_php).to include('<?php $text_2 = $my_repeater__fields__["text_2"]; if ($text_2): ?>')
					expect(f.to_php).to include('<?php $text_3 = $my_repeater__fields__["text_3"]; if ($text_3): ?>')
				end
			end
		end
		context "with sub-repeaters" do
			it "contains correct eacherators" do
				# puts @repeater_field_with_sub.to_php
				@fields_with_sub.each do |f|
					expect(f.to_php).to include('<?php $my_sub_repeater = $my_repeater__fields__["my_sub_repeater"]; if ($my_sub_repeater): ?>')
					expect(f.to_php).to include('<?php $text_1 = $my_sub_repeater__fields__["text_1"]; if ($text_1): ?>')
					expect(f.to_php).to include('<?php $text_2 = $my_sub_repeater__fields__["text_2"]; if ($text_2): ?>')
					expect(f.to_php).to include('<?php $text_3 = $my_sub_repeater__fields__["text_3"]; if ($text_3): ?>')
				end
			end
		end
	end
	describe '#to_xml' do
		it "returns a hash" do
			# puts @repeater_field_without_sub.to_xml
			# pp @repeater_field_with_sub.to_xml
			@fields.each do |f|
				expect(f.to_xml).to be_an_instance_of Hash
			end
		end
		context "without sub-repeaters" do
			it "contains correct subfields" do
				@fields_without_sub.each do |f|
					expect(f.to_xml[:sub_fields].size).to eq 4
				end
			end
		end
		context "with sub-repeaters" do
			it "contains correct subfields" do
				@fields_with_sub.each do |f|
					expect(f.to_xml[:sub_fields].size).to eq 1
					expect(f.to_xml[:sub_fields][0][:"name"]).to eq("my_sub_repeater")
					expect(f.to_xml[:sub_fields][0][:sub_fields].size).to eq 4
				end
			end
		end
	end
end
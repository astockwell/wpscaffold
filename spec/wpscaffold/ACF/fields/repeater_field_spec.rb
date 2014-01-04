require 'spec_helper'

describe Wpscaffold::ACF::RepeaterField do
	before :all do
		@text_field1 = Wpscaffold::ACF::TextField.new( "text 1", 0 )
		@text_field2 = Wpscaffold::ACF::TextField.new( "text 2", 1 )
		@text_field3 = Wpscaffold::ACF::TextField.new( "text 3", 2 )
		@image_field1 = Wpscaffold::ACF::ImageField.new( "image 1", 3, image_size: 'custom_size' )

		@sub_repeater_field = Wpscaffold::ACF::RepeaterField.new( "my sub repeater", 0, child_fields: [@text_field1,@text_field2,@text_field3,@image_field1] )

		@repeater_field = Wpscaffold::ACF::RepeaterField.new( "my repeater", 0, child_fields: [@sub_repeater_field] )
		# Test class alias
		@r_field = Wpscaffold::ACF::RField.new( "my repeater", 0, child_fields: [@text_field1,@text_field2,@text_field3] )
		# Test factory
		@repeater_from_factory = Wpscaffold::ACF.create_field( "my repeater", :repeater, 0, child_fields: [@text_field1,@text_field2,@text_field3] )
	end

	# describe '#new' do
	# 	it "returns an instance of a text ACF field" do
	# 		expect(@text_field).to be_an_instance_of Wpscaffold::ACF::TextField
	# 		expect(@t_field).to be_an_instance_of Wpscaffold::ACF::TextField
	# 	end
	# end
	describe '#to_php' do
		it "returns a template as a string" do
			puts @repeater_field.to_php
			expect(@repeater_field.to_php).to be_an_instance_of String
			expect(@r_field.to_php).to be_an_instance_of String
			expect(@repeater_from_factory.to_php).to be_an_instance_of String
		end
	end
	# describe '#to_xml' do
	# 	it "returns a template as a string" do
	# 		expect(@text_field.to_xml).to be_an_instance_of Hash
	# 		expect(@t_field.to_xml).to be_an_instance_of Hash
	# 	end
	# 	it "responds to options params correctly" do
	# 		expect(@text_field.to_xml['formatting']).to eq "crazy"
	# 		expect(@t_field.to_xml['formatting']).to eq "crazy"
	# 	end
	# 	it "allows field-agnostic options to be modified" do
	# 		field = Wpscaffold::ACF::TextField.new( "name", 0, nil, xml: { formatting: "crazy" } )
	# 		expect(field.to_xml['required']).to eq "0"
	# 		field.options[:xml][:required] = '1'
	# 		expect(field.to_xml['required']).to eq "1"
	# 	end
	# 	it "allows field-specific options to be modified" do
	# 		field = Wpscaffold::ACF::TextField.new( "name", 0, nil, xml: { formatting: "crazy" } )
	# 		expect(field.to_xml['formatting']).to eq "crazy"
	# 		field.options[:xml][:formatting] = 'silly'
	# 		expect(field.to_xml['formatting']).to eq "silly"
	# 	end
	# end
end
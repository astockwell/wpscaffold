require 'spec_helper'

describe Wpscaffold::ACF::ImageField do
	before :all do
		@image_field = Wpscaffold::ACF::ImageField.new( "my image", 0, xml: { preview_size: "medium" } )
		# Test class alias
		@i_field = Wpscaffold::ACF::IField.new( "my image", 0, xml: { preview_size: "medium" } )
		# Test factory
		@image_from_factory = Wpscaffold::ACF.create_field( "my image", :image, 0, xml: { preview_size: "medium" } )
	end

	describe '#new' do
		it "returns an instance of a text ACF field" do
			expect(@image_field).to be_an_instance_of Wpscaffold::ACF::ImageField
			expect(@i_field).to be_an_instance_of Wpscaffold::ACF::ImageField
			expect(@image_from_factory).to be_an_instance_of Wpscaffold::ACF::ImageField
		end
	end
	describe '#to_php' do
		it "returns a template as a string" do
			expect(@image_field.to_php).to be_an_instance_of String
			expect(@i_field.to_php).to be_an_instance_of String
			expect(@image_from_factory.to_php).to be_an_instance_of String
		end
	end
	describe '#to_xml' do
		it "returns an object for xml parsing" do
			expect(@image_field.to_xml).to be_an_instance_of Hash
			expect(@i_field.to_xml).to be_an_instance_of Hash
			expect(@image_from_factory.to_xml).to be_an_instance_of Hash
		end
		it "responds to options params correctly" do
			expect(@image_field.to_xml['preview_size']).to eq "medium"
			expect(@i_field.to_xml['preview_size']).to eq "medium"
			expect(@image_from_factory.to_xml['preview_size']).to eq "medium"
		end
		it "allows field-agnostic options to be modified" do
			field = Wpscaffold::ACF::ImageField.new( "my image", 0, xml: { preview_size: "medium" } )
			expect(field.to_xml['required']).to eq "0"
			field.options[:xml][:required] = '1'
			expect(field.to_xml['required']).to eq "1"
		end
		it "allows field-specific options to be modified" do
			field = Wpscaffold::ACF::ImageField.new( "my image", 0, xml: { preview_size: "medium" } )
			expect(field.to_xml['preview_size']).to eq "medium"
			field.options[:xml][:preview_size] = 'large'
			expect(field.to_xml['preview_size']).to eq "large"
		end
	end

	context "without image size modifier" do
		describe '#to_php' do
			it "returns a template with the proper (default) image size" do
				expect(@image_field.to_php).to include '$my_image["url"]'
				expect(@i_field.to_php).to include '$my_image["url"]'
				expect(@image_from_factory.to_php).to include '$my_image["url"]'
			end
		end
	end
	context "with image size modifier" do
		describe '#to_php' do
			it "returns a template with the proper (modified) image size" do
				image_field = Wpscaffold::ACF::ImageField.new( "my image", 0, image_size: 'this_size', xml: { preview_size: "medium" } )
				i_field = Wpscaffold::ACF::IField.new( "my image", 0, image_size: 'this_size', xml: { preview_size: "medium" } )
				image_from_factory = Wpscaffold::ACF.create_field( "my image", :image, 0, image_size: 'this_size', xml: { preview_size: "medium" } )
				expect(image_field.to_php).to include '$my_image["sizes"]["this_size"]'
				expect(i_field.to_php).to include '$my_image["sizes"]["this_size"]'
				expect(image_from_factory.to_php).to include '$my_image["sizes"]["this_size"]'
			end
		end
	end
end
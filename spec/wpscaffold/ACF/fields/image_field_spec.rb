require 'spec_helper'

describe Wpscaffold::ACF::ImageField do
	before :all do
		@image_field = Wpscaffold::ACF::ImageField.new( "name", 0, [], preview_size: "medium" )
		# Test class alias as well
		@i_field = Wpscaffold::ACF::IField.new( "name", 0, [], preview_size: "medium" )
	end

	describe '#new' do
		it "returns an instance of a text ACF field" do
			expect(@image_field).to be_an_instance_of Wpscaffold::ACF::ImageField
			expect(@i_field).to be_an_instance_of Wpscaffold::ACF::ImageField
		end
	end
	describe '#to_php' do
		it "returns a template as a string" do
			expect(@image_field.to_php).to be_an_instance_of String
			expect(@i_field.to_php).to be_an_instance_of String
		end
	end
	describe '#to_xml' do
		it "returns a template as a string" do
			expect(@image_field.to_xml).to be_an_instance_of Hash
			expect(@i_field.to_xml).to be_an_instance_of Hash
		end
		it "responds to options params correctly" do
			expect(@image_field.to_xml['preview_size']).to eq "medium"
			expect(@i_field.to_xml['preview_size']).to eq "medium"
		end
		it "allows options to be modified" do
			field = Wpscaffold::ACF::ImageField.new( "name", 0, [], preview_size: "medium" )
			expect(field.to_xml['preview_size']).to eq "medium"
			field.options[:preview_size] = 'large'
			expect(field.to_xml['preview_size']).to eq "large"
		end
	end

	context "without image size modifier" do
		describe '#to_php' do
			it "returns a template with the proper (default) image size" do
				expect(@image_field.to_php).to include '$name["url"]'
				expect(@i_field.to_php).to include '$name["url"]'
			end
		end
	end
	context "with image size modifier" do
		describe '#to_php' do
			it "returns a template with the proper (modified) image size" do
				field = Wpscaffold::ACF::ImageField.new( "name", 0, ['this_size'] )
				expect(field.to_php).to include '$name["sizes"]["this_size"]'
			end
		end
	end
end
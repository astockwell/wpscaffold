require 'spec_helper'

describe Wpscaffold::ACF::FieldGroup do
	before :all do
		@field_group_empty = Wpscaffold::ACF::FieldGroup.new( "Group Name" )
		@fields = [
			Wpscaffold::ACF::TextField.new( "field 1", 0 ),
			Wpscaffold::ACF::TextField.new( "field 2", 1 ),
			Wpscaffold::ACF::TextField.new( "field 3", 2 ),
		]
		@field_group_three = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
	end

	describe '#new' do
		context "without fields" do
			it "creates an instance of a ACF FieldGroup object" do
				expect(@field_group_empty).to be_an_instance_of Wpscaffold::ACF::FieldGroup
			end
			it "populates the title correctly" do
				expect(@field_group_empty.title).to eq "Group Name"
			end
		end
		context "with fields" do
			it "creates an instance of a ACF FieldGroup object" do
				expect(@field_group_three).to be_an_instance_of Wpscaffold::ACF::FieldGroup
			end
			it "populates the title correctly" do
				expect(@field_group_three.title).to eq "Group Name"
			end
			it "contains three fields" do
				expect(@field_group_three).to have(3).fields
			end
		end
	end

	describe '#to_xml' do
		it "has a :title" do
			# pp @field_group_three.to_xml
			expect(@field_group_three.to_xml).to have_key(:title)
			expect(@field_group_three.to_xml[:title]).to eq "Group Name"
		end
		it "has a :post_name" do
			expect(@field_group_three.to_xml).to have_key(:post_name)
			expect(@field_group_three.to_xml[:post_name]).to eq "acf_group-name"
		end
		it "has a proper :post_type" do
			expect(@field_group_three.to_xml).to have_key(:post_type)
			expect(@field_group_three.to_xml[:post_type]).to eq "acf"
		end
		it "contains proper fieldgroup postmeta keys" do
			expect(@field_group_three.to_xml).to have_key(:postmeta)
			expect(@field_group_three.to_xml[:postmeta]).to have(7).Hashes
		end
	end

	describe '#to_php' do
		it "returns a string" do
			# puts @field_group_three.to_php
			expect(@field_group_three.to_php).to be_a String
		end
		it "contains three fields" do
			expect(@field_group_three.to_php).to include '$field_1'
			expect(@field_group_three.to_php).to include 'get_field("field_1")'
			expect(@field_group_three.to_php).to include '$field_2'
			expect(@field_group_three.to_php).to include 'get_field("field_2")'
			expect(@field_group_three.to_php).to include '$field_3'
			expect(@field_group_three.to_php).to include 'get_field("field_3")'
		end
	end
end
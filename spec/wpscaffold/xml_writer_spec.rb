require 'spec_helper'

describe Wpscaffold::XmlWriter do
	before :all do
		@fields = [
			Wpscaffold::ACF::TextField.new( "field 1", 0 ),
			Wpscaffold::ACF::TextField.new( "field 2", 1 ),
			Wpscaffold::ACF::TextField.new( "field 3", 2 ),
		]
		@field_group = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
		@xml_empty   = Wpscaffold::XmlWriter.new()
		@xml_three   = Wpscaffold::XmlWriter.new([@field_group])
	end

	describe '#new' do
		it "creates an instance of a XmlWriter object" do
			expect(@xml_empty).to be_a Wpscaffold::XmlWriter
			expect(@xml_three).to be_a Wpscaffold::XmlWriter
		end
	end

	describe '#render' do
		it "renders all items to xml" do
			# pp @xml_empty.render
			# pp @xml_three.render
			expect(@xml_empty.render).to be_a String
			expect(@xml_three.render).to be_a String
		end
	end
end
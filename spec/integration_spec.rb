require 'spec_helper'

describe "Wpscaffold Integration Test" do
	describe "create a static page" do
		it "renders xml" do
			@fields = [
				Wpscaffold::ACF::TextField.new( "field 1", 0 ),
				Wpscaffold::ACF::TextField.new( "field 2", 1 ),
				Wpscaffold::ACF::TextField.new( "field 3", 2 ),
			]
			@field_group = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
			@static = Wpscaffold::Core.create_template "Static", "Page Name", fields: @field_group
			@xml_three = Wpscaffold::XmlWriter.new([@static, @field_group])
			puts @xml_three.render
		end
	end
end
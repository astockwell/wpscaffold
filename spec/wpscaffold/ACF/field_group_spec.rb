require 'spec_helper'

describe Wpscaffold::ACF::FieldGroup do
	before :each do
		@field_group = Wpscaffold::ACF::FieldGroup.new( name: "Group Name" )
	end

	describe '#new' do
		it "creates an instance of a ACF FieldGroup object" do
			expect(@field_group).to be_an_instance_of Wpscaffold::ACF::FieldGroup
		end
	end
end
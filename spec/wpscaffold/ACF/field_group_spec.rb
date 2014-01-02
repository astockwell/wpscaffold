require 'spec_helper'

describe Wpscaffold::ACF::FieldGroup do
	before :all do
		@field_group_empty = Wpscaffold::ACF::FieldGroup.new( "Group Name" )
	end

	describe '#new' do
		it "creates an instance of a ACF FieldGroup object" do
			expect(@field_group_empty).to be_an_instance_of Wpscaffold::ACF::FieldGroup
		end
		it "populates the title correctly" do
			expect(@field_group_empty.title).to eq "Group Name"
		end
	end

	describe '#field_factory' do
		it "creates the correct instance of a field subclass" do
			instance = @field_group_empty.field_factory('title', 'text', 0)
			expect(instance).to be_an_instance_of Wpscaffold::ACF::TextField
		end
		it "returns an error for a non-existant subclass" do
			expect{ @field_group_empty.field_factory('title', 'nevergoingtoexist') }.to raise_error(ArgumentError)
		end
	end
end
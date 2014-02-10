require 'spec_helper'

describe Wpscaffold::Builder do
	before :all do
		@fields = [
			Wpscaffold::ACF::TextField.new( "field 1", 0 ),
			Wpscaffold::ACF::TextField.new( "field 2", 1 ),
			Wpscaffold::ACF::TextField.new( "field 3", 2 ),
		]
		@field_group_three = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
		@cpt = Wpscaffold::Builder.cpt "Event", @field_group_three
	end

	describe 'self.cpt' do
		it 'test' do
			# pp @cpt
		end
	end
end
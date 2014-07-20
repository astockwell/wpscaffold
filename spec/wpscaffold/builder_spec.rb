# require 'spec_helper'

# describe Wpscaffold::Builder do
# 	before :all do
# 		@fields = [
# 			Wpscaffold::ACF::TextField.new( "text box 1", 0 ),
# 			Wpscaffold::ACF::TextField.new( "text box 2", 1 ),
# 			Wpscaffold::ACF::TextField.new( "text box 3", 2 ),
# 		]
# 		@field_group_three = Wpscaffold::ACF::FieldGroup.new( "Event Group", @fields, value: 'event' )
# 		@cpt = Wpscaffold::Builder.cpt "Event", @field_group_three
# 	end

# 	describe 'self.cpt' do
# 		it 'test' do
# 			# pp @cpt
# 		end
# 	end
# end
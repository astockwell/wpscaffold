require 'spec_helper'

describe Wpscaffold::ACF do
	# before :all do
	# 	@field = Wpscaffold::ACF.create_field( "my field", :text, 0 )
	# end

	describe '#field_factory' do
		it "creates the correct instance of a field subclass" do
			instance = Wpscaffold::ACF.create_field('title', :text, 0)
			expect(instance).to be_an_instance_of Wpscaffold::ACF::TextField
		end
		it "returns an error for a non-existant subclass" do
			expect{ Wpscaffold::ACF.create_field('title', :nevergoingtoexist, 0) }.to raise_error(ArgumentError)
		end
	end
end
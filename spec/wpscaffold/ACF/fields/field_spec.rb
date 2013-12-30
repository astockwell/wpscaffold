require 'spec_helper'

describe Wpscaffold::ACF::Field do
	before :each do
		@field = Wpscaffold::ACF::Field.new( name: "Field Name" )
	end

	describe '#new' do
		it "creates an instance of a generic ACF field" do
			expect(@field).to be_an_instance_of Wpscaffold::ACF::Field
		end
		it "raises an error if #to_php or #to_xml is called on the generic object" do
	        expect { @field.to_php }.to raise_error(NotImplementedError)
	        expect { @field.to_xml }.to raise_error(NotImplementedError)
	    end
	end
end
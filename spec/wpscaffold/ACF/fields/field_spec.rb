require 'spec_helper'

describe Wpscaffold::ACF::Field do
	before :each do
		@field = Wpscaffold::ACF::Field.new( "name:text" )
	end

	describe '#new' do
		it "creates an instance of a generic ACF field" do
			expect(@field).to be_an_instance_of Wpscaffold::ACF::Field
		end
		it "raises an error if the fieldtype not specified (split ':' length is <= 1)" do
	        expect { Wpscaffold::ACF::Field.new( "name" ) }.to raise_error(ArgumentError)
	    end
		it "raises an error if the fieldtype is undefined" do
	        expect { Wpscaffold::ACF::Field.new( "name:thisfieldtypedoesnotexist" ) }.to raise_error(ArgumentError)
	    end
	end
	describe '#to_php' do
		it "raises an error if called on the generic object" do
	        expect { @field.to_php }.to raise_error(NotImplementedError)
	    end
	end
	describe '#to_xml' do
		it "raises an error if called on the generic object" do
	        expect { @field.to_xml }.to raise_error(NotImplementedError)
	    end
	end
end
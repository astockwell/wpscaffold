require 'spec_helper'

describe Wpscaffold::ACF::Field do
	before :all do
		@field = Wpscaffold::ACF::Field.new( "raw field name", 0 )
	end

	describe '#new' do
		it "creates an instance of a generic ACF field" do
			expect(@field).to be_an_instance_of Wpscaffold::ACF::Field
		end
		it "properly populates the default attributes" do
			expect(@field.label).to eq 'Raw Field Name'
			expect(@field.name).to eq 'raw_field_name'
			expect(@field.order_no).to eq 0
			expect(@field.key).to be_an_instance_of String
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
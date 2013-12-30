require 'spec_helper'

describe Wpscaffold::Controller do
	it "broccoli is gross" do
		Wpscaffold::Controller.portray("Broccoli").should eql("Gross!")
	end
end
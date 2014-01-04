require 'spec_helper'

describe Wpscaffold::ACF::TextField do
	before :all do
		@text_field = Wpscaffold::ACF::TextField.new( "name", 0, nil, [], xml: { formatting: "crazy" } )
		# Test class alias
		@t_field = Wpscaffold::ACF::TField.new( "name", 0, nil, [], xml: { formatting: "crazy" } )
		# Test factory
		@text_from_factory = Wpscaffold::ACF.create_field( "name", :text, 0, nil, [], xml: { formatting: "crazy" } )
	end

	describe '#new' do
		it "returns an instance of a text ACF field" do
			expect(@text_field).to be_an_instance_of Wpscaffold::ACF::TextField
			expect(@t_field).to be_an_instance_of Wpscaffold::ACF::TextField
		end
	end
	describe '#to_php' do
		it "returns a template as a string" do
			expect(@text_field.to_php).to be_an_instance_of String
			expect(@t_field.to_php).to be_an_instance_of String
		end
	end
	describe '#to_xml' do
		it "returns a template as a string" do
			expect(@text_field.to_xml).to be_an_instance_of Hash
			expect(@t_field.to_xml).to be_an_instance_of Hash
		end
		it "responds to options params correctly" do
			expect(@text_field.to_xml['formatting']).to eq "crazy"
			expect(@t_field.to_xml['formatting']).to eq "crazy"
		end
		it "allows field-agnostic options to be modified" do
			field = Wpscaffold::ACF::TextField.new( "name", 0, nil, [], xml: { formatting: "crazy" } )
			expect(field.to_xml['required']).to eq "0"
			field.options[:xml][:required] = '1'
			expect(field.to_xml['required']).to eq "1"
		end
		it "allows field-specific options to be modified" do
			field = Wpscaffold::ACF::TextField.new( "name", 0, nil, [], xml: { formatting: "crazy" } )
			expect(field.to_xml['formatting']).to eq "crazy"
			field.options[:xml][:formatting] = 'silly'
			expect(field.to_xml['formatting']).to eq "silly"
		end
	end
end
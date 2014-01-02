require 'spec_helper'

describe Wpscaffold::ACF do
	describe 'integration test for ACF FieldGroup: flat' do
		it 'creates an instance of a ACF FieldGroup with the proper ACF Field instances in an ACF FieldList' do
			acf = Wpscaffold::ACF::FieldGroup.new( "Field Group Name", ['title:text', 'description:text'] )
			expect(acf).to be_an_instance_of Wpscaffold::ACF::FieldGroup
			expect(acf.title).to eq "Field Group Name"
			expect(acf.fieldlist).to be_an_instance_of Wpscaffold::ACF::FieldList
			expect(acf.fieldlist.fields[0]).to be_an_instance_of Wpscaffold::ACF::TextField
			expect(acf.fieldlist.fields[1]).to be_an_instance_of Wpscaffold::ACF::TextField
			# puts acf.fieldlist.fields[0].to_php
			# puts acf.fieldlist.fields[0].to_xml
		end
	end
end
require 'spec_helper'

describe Wpscaffold::ACF do
	describe 'integration test for ACF FieldGroup: flat' do
		before :all do
			@field_a = Wpscaffold::ACF.create_field( "title", :text, 0 )
			@field_b = Wpscaffold::ACF.create_field( "description", :text, 1 )
			@field_c = Wpscaffold::ACF.create_field( "author", :text, 2 )
		end
		let(:acf) { Wpscaffold::ACF::FieldGroup.new( "Field Group Name", [@field_a, @field_b, @field_c] ) }

		context Wpscaffold::ACF::FieldGroup do
			it { expect(acf).to be_an_instance_of Wpscaffold::ACF::FieldGroup }
			it { expect(acf.title).to eq "Field Group Name" }
			it { expect(acf.fields).to have(3).fields }
		end
		context "fields" do
			it { expect(acf.fields[0]).to be_an_instance_of Wpscaffold::ACF::TextField }
			it { expect(acf.fields[1]).to be_an_instance_of Wpscaffold::ACF::TextField }
			it { expect(acf.fields[2]).to be_an_instance_of Wpscaffold::ACF::TextField }
			it { expect(acf.fields[0].order_no).to eq 0 }
			it { expect(acf.fields[1].order_no).to eq 1 }
			it { expect(acf.fields[2].order_no).to eq 2 }
			# it { puts fields[0].to_php }
			# it { puts fields[0].to_xml }
		end
	end
end
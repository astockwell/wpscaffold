require 'spec_helper'

describe Wpscaffold::ACF do
	describe 'integration test for ACF FieldGroup: flat' do
		let(:acf) { Wpscaffold::ACF::FieldGroup.new( "Field Group Name", ['title:text', 'description:text', 'author:text'] ) }

		context Wpscaffold::ACF::FieldGroup do
			it { expect(acf).to be_an_instance_of Wpscaffold::ACF::FieldGroup }
			it { expect(acf.title).to eq "Field Group Name" }
		end
		context Wpscaffold::ACF::FieldList do
			it { expect(acf.fieldlist).to be_an_instance_of Wpscaffold::ACF::FieldList }
			it { expect(acf.fieldlist).to have(3).fields }
		end
		context Wpscaffold::ACF::Field do
			subject(:fields) { acf.fieldlist.fields }
			it { expect(fields[0]).to be_an_instance_of Wpscaffold::ACF::TextField }
			it { expect(fields[1]).to be_an_instance_of Wpscaffold::ACF::TextField }
			it { expect(fields[2]).to be_an_instance_of Wpscaffold::ACF::TextField }
			it { expect(fields[0].order_no).to eq 0 }
			it { expect(fields[1].order_no).to eq 1 }
			it { expect(fields[2].order_no).to eq 2 }
			# it { puts fields[0].to_php }
			# it { puts fields[0].to_xml }
		end
	end
end
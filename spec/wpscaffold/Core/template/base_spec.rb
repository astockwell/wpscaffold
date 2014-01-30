require 'spec_helper'

describe Wpscaffold::Core::Template::Base do
	before :all do
		@template = Wpscaffold::Core.create_template "Base", "template name", option: "some option value"
	end

	describe '#new' do
		it "returns the correct class" do
			expect(@template).to be_a Wpscaffold::Core::Template::Base
		end
		it "stores the template name" do
			expect(@template.name).to eq "template name"
		end
		it "stores the template option(s)" do
			expect(@template.options).to eq({ option: "some option value" })
		end
	end
	describe '#filename' do
		it "returns correct error" do
			expect { @template.filename }.to raise_error(NotImplementedError)
		end
	end
	describe '#to_php' do
		it "returns correct error" do
			expect { @template.to_php }.to raise_error(NotImplementedError)
		end
	end
	describe '#to_xml' do
		it "returns correct error" do
			expect { @template.to_xml }.to raise_error(NotImplementedError)
		end
	end
end
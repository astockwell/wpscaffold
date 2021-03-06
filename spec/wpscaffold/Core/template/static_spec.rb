require 'spec_helper'

describe Wpscaffold::Core::Template::Static do
	before :all do
		@fields = [
			Wpscaffold::ACF::TextField.new( "field 1", 0 ),
			Wpscaffold::ACF::TextField.new( "field 2", 1 ),
			Wpscaffold::ACF::TextField.new( "field 3", 2 ),
		]
		@field_group = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
		@static = Wpscaffold::Core.create_template "Static", "Page Name", field_group: @field_group
	end

	describe '#to_php' do
		it "returns a string" do
			expect(@static.to_php).to be_a String
		end
		it "renders correctly" do
			expect(@static.to_php).to eq %Q[<?php get_header(); ?>\n\n		<section>\n\n			<?php if(have_posts()) : while(have_posts()) : the_post(); ?><!-- start loop -->\n				<article>\n\n					<?php $field_1 = get_field("field_1"); if ($field_1): ?>\n						<?php echo $field_1; ?>\n					<?php endif; ?>\n					<?php $field_2 = get_field("field_2"); if ($field_2): ?>\n						<?php echo $field_2; ?>\n					<?php endif; ?>\n					<?php $field_3 = get_field("field_3"); if ($field_3): ?>\n						<?php echo $field_3; ?>\n					<?php endif; ?>\n\n				</article>\n			<?php endwhile; endif; ?><!-- end loop -->\n\n		</section>\n\n		<?php //get_sidebar(); ?><!-- optional -->\n\n<?php get_footer(); ?>]
		end
	end

	describe '#to_xml' do
		it "returns an object" do
			# puts @static.to_xml
			expect(@static.to_xml).to be_a Hash
		end
		it "contains the correct key/values" do
			expect(@static.to_xml).to eq({:title=>"Page Name", :post_name=>"page-name", :post_type=>"page", :post_id=>nil, :content=>nil, :excerpt=>nil, :postmeta=>[{:"wp:meta_key"=>"_wp_page_template", :"wp:meta_value!"=>"<![CDATA[default]]>"}]})
		end
		it "allows for the changing of values" do
			static_t = Wpscaffold::Core.create_template "Static", "Page Name", field_group: @field_group, content: "this is some content"
			expect(static_t.to_xml).to eq({:title=>"Page Name", :post_name=>"page-name", :post_type=>"page", :post_id=>nil, :content=>"this is some content", :excerpt=>nil, :postmeta=>[{:"wp:meta_key"=>"_wp_page_template", :"wp:meta_value!"=>"<![CDATA[default]]>"}]})
		end
	end
end
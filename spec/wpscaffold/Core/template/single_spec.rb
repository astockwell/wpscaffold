require 'spec_helper'

describe Wpscaffold::Core::Template::Single do
	before :all do
		@fields = [
			Wpscaffold::ACF::TextField.new( "field 1", 0 ),
			Wpscaffold::ACF::TextField.new( "field 2", 1 ),
			Wpscaffold::ACF::TextField.new( "field 3", 2 ),
		]
		@field_group = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
		@single = Wpscaffold::Core.create_template "Single", "my post type", fields: @field_group
	end

	describe '#to_php' do
		it "returns a string" do
			# puts @single.to_php
			expect(@single.to_php).to be_a String
		end
		it "renders correctly" do
			expect(@single.to_php).to eq %Q[<?php get_header(); ?>\n\n		<section>\n\n			<?php if(have_posts()) : while(have_posts()) : the_post(); ?><!-- start loop -->\n				<article>\n\n					<?php $field_1 = get_field("field_1"); if ($field_1): ?>\n						<?php echo $field_1; ?>\n					<?php endif; ?>\n					<?php $field_2 = get_field("field_2"); if ($field_2): ?>\n						<?php echo $field_2; ?>\n					<?php endif; ?>\n					<?php $field_3 = get_field("field_3"); if ($field_3): ?>\n						<?php echo $field_3; ?>\n					<?php endif; ?>\n\n				</article>\n			<?php endwhile; endif; ?><!-- end loop -->\n\n		</section>\n\n		<?php //get_sidebar(); ?><!-- optional -->\n\n<?php get_footer(); ?>]
		end
	end
	describe '#to_xml' do
		it "returns false" do
			expect(@single.to_xml).to eq false
		end
	end
end
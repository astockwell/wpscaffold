require 'spec_helper'

describe Wpscaffold::Core::Template::Archive do
	before :all do
		@fields = [
			Wpscaffold::ACF::TextField.new( "field 1", 0 ),
			Wpscaffold::ACF::TextField.new( "field 2", 1 ),
			Wpscaffold::ACF::TextField.new( "field 3", 2 ),
		]
		@field_group = Wpscaffold::ACF::FieldGroup.new( "Group Name", @fields )
		@archive = Wpscaffold::Core.create_template "Archive", "my post type", field_group: @field_group
	end

	describe '#to_php' do
		it "returns a string" do
			# puts @archive.to_php
			expect(@archive.to_php).to be_a String
		end
		it "renders correctly" do
			expect(@archive.to_php).to eq %Q[<?php get_header(); ?>\n\n		<section>\n\n			<?php if(have_posts()) : while(have_posts()) : the_post(); ?><!-- start loop -->\n				<article>\n\n					<?php $field_1 = get_field("field_1"); if ($field_1): ?>\n						<?php echo $field_1; ?>\n					<?php endif; ?>\n					<?php $field_2 = get_field("field_2"); if ($field_2): ?>\n						<?php echo $field_2; ?>\n					<?php endif; ?>\n					<?php $field_3 = get_field("field_3"); if ($field_3): ?>\n						<?php echo $field_3; ?>\n					<?php endif; ?>\n\n				</article>\n			<?php endwhile; endif; ?><!-- end loop -->\n\n			<div class="pagination">\n				<?php $args = array(\n					'base'         => get_bloginfo('url') . '/my_post_type/%_%',\n					'format'       => 'page/%#%/', //url format is "/my_post_type/page/#"\n					'total'        => $wp_query->max_num_pages,\n					'current'      => max( 1, $wp_query->query_vars['paged'] ),\n					'show_all'     => true,\n					'prev_next'    => True,\n					'prev_text'    => __('&larr;'),\n					'next_text'    => __('&rarr;'),\n					'type'         => 'plain',\n					'add_args'     => False,\n					'add_fragment' => ''\n				);\n				echo paginate_links( $args ); ?>\n			</div>\n\n		</section>\n\n		<?php //get_sidebar(); ?><!-- optional -->\n\n<?php get_footer(); ?>]
		end
	end
	describe '#to_xml' do
		it "returns false" do
			expect(@archive.to_xml).to eq false
		end
	end
end
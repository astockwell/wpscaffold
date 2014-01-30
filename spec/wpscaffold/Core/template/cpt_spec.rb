require 'spec_helper'

describe Wpscaffold::Core::Template::CPT do
	before :all do
		@cpt = Wpscaffold::Core.create_template "CPT", "my post type"
	end

	describe '#to_php' do
		it "returns a string" do
			expect(@cpt.to_php).to be_a String
		end
		it "renders correctly" do
			# puts @cpt.to_php
			expect(@cpt.to_php).to eq %Q[<?php\n\nfunction create_cpt_my_post_type() {\n	$label_singular = 'My Post Type';\n	$label_plural = 'My Post Types';\n\n	$labels = array(\n		'name' => __($label_plural),\n		'singular_name' => __($label_singular),\n		'add_new' => __('Add New'),\n		'add_new_item' => __('Add New ' . $label_singular),\n		'edit_item' => __('Edit ' . $label_singular),\n		'new_item' => __('New ' . $label_singular),\n		'all_items' => __('All ' . $label_plural),\n		'view_item' => __('View ' . $label_singular),\n		'search_items' => __('Search ' . $label_plural),\n		'not_found' => __( 'No ' . $label_plural . ' found'),\n		'not_found_in_trash' => __('No ' . $label_plural . ' found in Trash'),\n		'parent_item_colon' => __(''),\n		'menu_name' => __($label_plural)\n	);\n\n	$args = array(\n		'labels' => $labels,\n		'public' => true,\n		'has_archive' => true,\n		'hierarchical' => false,\n		// 'rewrite' => array( 'with_front' => false, 'slug' => 'my_post_type' ),\n		// 'show_in_menu' => true,\n		// 'menu_position' => 5,\n		'supports' => array(\n				'title',\n				'editor',\n				// 'author',\n				// 'thumbnail',\n				// 'excerpt',\n				// 'trackbacks',\n				// 'comments',\n				// 'post-formats',\n				'custom-fields',\n				'revisions',\n				'page-attributes'\n			)\n	);\n	register_post_type( 'my_post_type', $args ); // Singular! slug!\n}\nadd_action( 'init', 'create_cpt_my_post_type' );]
		end
	end
	describe '#to_xml' do
		it "returns false" do
			expect(@cpt.to_xml).to eq false
		end
	end
end
clean:
	@rm -rf wp/
	@mkdir -p wp/sass/{archive,single}
	@mkdir -p wp/lib/cpts
	@echo "// Imports section" >> wp/sass/screen.scss
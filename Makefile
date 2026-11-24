# edit this Makefile as necessary for your project
.PHONY: install fonts pdf

install:
	echo "installed (test message)"

fonts: ## Subset the vendored web fonts to the characters used in slides-jp/index.html
	scripts/subset-fonts.sh

pdf: ## Export the slides to slides-jp/slides-jp.pdf with decktape (DECKTAPE_ARGS to change its options)
	$(MAKE) -C slides-jp slides-jp

# edit this Makefile as necessary for your project
.PHONY: install fonts pdf serve

# Where `make serve` listens; override on the command line, e.g. `make serve PORT=8080`.
# HOST=0.0.0.0 exposes the deck to the local network. These use `=`, not `?=`, so a
# HOST or PORT exported for another tool does not change where the deck is served.
PORT = 8000
HOST = 127.0.0.1

install:
	echo "installed (test message)"

fonts: ## Subset the vendored web fonts to the characters used in slides-jp/index.html
	scripts/subset-fonts.sh

pdf: ## Export the slides to slides-jp/slides-jp.pdf with decktape (DECKTAPE_ARGS to change its options)
	$(MAKE) -C slides-jp slides-jp

# A plain static server: reveal.js's `npm start` (gulp serve) does not start on Node.js 26.
serve: ## Serve slides-jp/ at http://localhost:8000 (PORT=, HOST= to change; Ctrl-C to stop)
	python3 -m http.server $(PORT) --bind $(HOST) --directory slides-jp

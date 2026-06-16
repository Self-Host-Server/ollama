.PHONY: all fmt lint

all:
	pip install -r requirements.txt
	npm install

fmt:
	npx prettier --write "**/*.{ts,tsx,css,scss,md}"
	git add .
	git commit -m "Format code" || echo "No changes to commit"

lint:
	make fmt
	tox -e all

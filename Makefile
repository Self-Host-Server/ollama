.PHONY: fmt lint

fmt:
	npx prettier --write "**/*.{ts,tsx,css,scss,md}"
	git add .
	git commit -m "Format code" || echo "No changes to commit"

lint:
	make fmt
	tox -e all
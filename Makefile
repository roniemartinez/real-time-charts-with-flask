.PHONY: format
format:
	poetry run autoflake --remove-all-unused-imports --in-place -r --exclude __init__.py .
	poetry run isort .
	poetry run black .

.PHONY: lint
lint:
	poetry run autoflake --remove-all-unused-imports --in-place -r --exclude __init__.py --check .
	poetry run isort --check-only .
	poetry run black --check .
	poetry run pflake8 .
	poetry run mypy .


.PHONY: tag
tag:
	VERSION=`poetry version | grep -o -E "\d+\.\d+\.\d+"`; \
	git tag -s -a $$VERSION -m "Release $$VERSION"

.PHONY: requirements.txt
requirements.txt:
	poetry export -f requirements.txt --output requirements.txt --without-hashes

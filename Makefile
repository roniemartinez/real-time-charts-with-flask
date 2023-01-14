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
	VERSION=`poetry version --short`; \
	git tag -s -a $$VERSION -m "Release $$VERSION"; \
	echo "Tagged $$VERSION";

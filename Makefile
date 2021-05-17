.PHONY: requirements.txt
requirements.txt:
	poetry export -f requirements.txt --output requirements.txt --without-hashes

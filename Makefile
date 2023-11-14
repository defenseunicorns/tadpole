VERSION := $(shell git describe --abbrev=0 --tags)

create-venv:
	python -m venv .venv

activate-venv:
	source .venv/bin/activate

submodules:
	git submodule update --init --recursive

requirements-dev:
	find . -name 'requirements-dev.txt' -exec pip install -r {} \;

requirements:
	find . -name 'requirements.txt' -exec pip install -r {} \;

test:
	pytest **/*.py

dev:
	uvicorn main:app --app-dir ./api/* --port 3000 &
	find backend/* -name "main.py" -execdir python {} \;
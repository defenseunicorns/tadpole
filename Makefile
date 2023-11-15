VERSION := $(shell git describe --abbrev=0 --tags)

create-venv:
	python -m venv .venv

activate-venv:
	source .venv/bin/activate

submodules:
	git submodule update --init --recursive

build-requirements:
	find . -name 'pyproject.toml' -exec pip-compile --strip-extras -o requirements.txt {} \;

build-requirements-dev:
	find . -name 'pyproject.toml' -exec pip-compile --strip-extras --extra dev -o requirements-dev.txt {} \;

requirements-dev:
	python -m pip install -r requirements-dev.txt

requirements:
	python -m pip install -r requirements.txt

test:
	pytest **/*.py

dev:
	uvicorn main:app --app-dir ./api/* --port 3000 &
	find backend/* -name "main.py" -execdir python {} \;
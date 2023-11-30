VERSION := $(shell git describe --abbrev=0 --tags)

create-venv:
	python -m venv .venv

activate-venv:
	source .venv/bin/activate

submodules:
	git submodule update --init --recursive

docker-compose:
	docker-compose up -d

docker-compose-build:
	docker-compose build --no-cache

docker-compose-down:
	docker-compose down
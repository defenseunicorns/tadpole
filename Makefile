VERSION := $(shell git describe --abbrev=0 --tags)
ARCH := $(shell uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)

create-venv:
	python -m venv .venv

activate-venv:
	source .venv/bin/activate

submodules:
	git submodule update --init --recursive

docker-compose:
	docker-compose up -d

docker-compose-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker-compose build --no-cache --build-arg ARCH=${ARCH}

docker-compose-down:
	docker-compose down
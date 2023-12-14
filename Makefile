ARCH := $(shell uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)

create-venv:
	python -m venv .venv

activate-venv:
	source .venv/bin/activate

submodules:
	git submodule update --init --recursive

docker-compose:
	docker compose up -d

docker-compose-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose build --no-cache --build-arg ARCH=${ARCH}

code-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose -f docker-compose-code.yml build --no-cache --build-arg ARCH=${ARCH}

code-up:
	docker compose -f docker-compose-code.yml up -d

docker-compose-down:
	docker compose down

clean:
	make docker-compose-down
	docker image rm -f tadpole-frontend 2> /dev/null
	docker image rm -f tadpole-backend 2> /dev/null
	docker image rm -f tadpole-backend-transcribe 2> /dev/null
	docker image rm -f tadpole-api 2> /dev/null

clean-unsafe:
	make clean
	docker image prune -f

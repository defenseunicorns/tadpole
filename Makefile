#!/usr/bin/make

SHELL := /bin/bash

include ./env/env-docker
include ./env/env-chromadb
include ./env/env-watchdog
include ./env/env-lfai

ARCH := $(shell uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)
UI := http://localhost:3000/

create-venv:
	python -m venv .venv

activate-venv:
	source .venv/bin/activate

submodules:
	git submodule update --init --recursive

code:
	make submodules
	make code-build
	make code-up

chat:
	make submodules
	make chat-build
	make chat-up
	echo "Leapfrog UI running at: $(UI)"

chat-gpu:
	make submodules
	make chat-gpu-build
	make chat-gpu-up
	echo "Leapfrog UI running at: $(UI)"

code-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose -f recipes/code/docker-compose.yml build --no-cache --build-arg ARCH=${ARCH}

code-up:
	docker compose -f recipes/code/docker-compose.yml up -d

chat-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose -f ./docker-compose.yml --profile chat --verbose build --no-cache --build-arg ARCH=${ARCH}

chat-up:
	docker compose -f ./docker-compose.yml --profile chat --verbose  up -d

chat-gpu-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose -f ./docker-compose.yml --profile chat-gpu --verbose  build --no-cache --build-arg ARCH=${ARCH}

chat-gpu-up:
	docker compose -f ./docker-compose.yml --profile chat-gpu --verbose up -d

docker-compose-down:
	docker compose -f ./docker-compose.yml --profile chat-gpu down

clean:
	make docker-compose-down
	docker image rm -f chat-frontend 2> /dev/null
	docker image rm -f chat-backend 2> /dev/null
	docker image rm -f chat-api 2> /dev/null
	docker image rm -f chat-gpu-frontend 2> /dev/null
	docker image rm -f chat-gpu-backend 2> /dev/null
	docker image rm -f chat-gpu-api 2> /dev/null
	docker image rm -f code-backend 2> /dev/null
	docker image rm -f code-api 2> /dev/null

clean-unsafe:
	make docker-compose-down
	docker image prune -f

rag-build:
	make submodules
	make env-init
	docker compose -f ./docker-compose.yml --profile rag --verbose  build --no-cache --build-arg ARCH=${ARCH}

rag-up:
	make persistence-dirs-create
	make rag-down
	docker compose -f ./docker-compose.yml --profile rag --verbose up -d
	watch docker ps -a

rag-down:
	docker compose -f ./docker-compose.yml --profile rag down

rag-launch:
	make rag-build
	make rag-up	

persistence-dirs-create:
	bin/managedirs

persistence-dirs-clean:
	bin/managedirs clean

persistence-dirs-watch:
	watch -n 4 tree ${PERSISTENCE_DIR}	

env-init:
	if [ ! -f ./env/env-secrets ]; then \
		read -sp "enter OPENAI_API_KEY:" openapi_key && echo "OPENAI_API_KEY=$${openapi_key}" >./env/env-secrets; \
	fi	
	cat ./env/env-secrets	
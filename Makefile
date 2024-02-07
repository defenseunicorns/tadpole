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
	docker compose -f recipes/code/docker-compose.yml build --build-arg ARCH=${ARCH}

code-up:
	docker compose -f recipes/code/docker-compose.yml up -d

chat-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose -f recipes/chat/docker-compose.yml build --build-arg ARCH=${ARCH}

chat-up:
	docker compose -f recipes/chat/docker-compose.yml up -d

chat-gpu-build:
	if ! [ -f backend/leapfrogai-backend-llama-cpp-python/config.yaml ]; then \
		cp backend/leapfrogai-backend-llama-cpp-python/config.example.yaml backend/leapfrogai-backend-llama-cpp-python/config.yaml; \
	fi
	docker compose -f recipes/chat-gpu/docker-compose.yml build --build-arg ARCH=${ARCH}

chat-gpu-up:
	docker compose -f recipes/chat-gpu/docker-compose.yml up -d

rag-gpu:
	make submodules
	make rag-gpu-build
	make rag-gpu-up
	echo "RAG-GPU UI running at: $(UI)"

rag-gpu-build:
	if ! [ -f backend/leapfrogai-backend-rag/src/.env ]; then \
		cp backend/leapfrogai-backend-rag/.env.example backend/leapfrogai-backend-rag/src/.env; \
	fi
	docker compose -f recipes/rag-gpu/docker-compose.yml build --build-arg ARCH=${ARCH}

rag-gpu-up:
	docker compose -f recipes/rag-gpu/docker-compose.yml up -d

docker-compose-down:
	docker compose -f recipes/chat/docker-compose.yml down
	docker compose -f recipes/code/docker-compose.yml down
	docker compose -f recipes/chat-gpu/docker-compose.yml down
	docker compose -f recipes/rag-gpu/docker-compose.yml down

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
	docker image rm -f rag-gpu-frontend 2> /dev/null
	docker image rm -f rag-gpu-llm-backend 2> /dev/null
	docker image rm -f rag-gpu-embeddings-backend 2> /dev/null
	docker image rm -f rag-gpu-api 2> /dev/null

clean-unsafe:
	make docker-compose-down
	docker image prune -f

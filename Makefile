# Project variables
PROJECT_NAME ?= todobackend
ORG_NAME ?= ldiwa
REPO_NAME ?= todobackend

# Filename
DEV_COMPOSE_FILE := docker/dev/docker-compose.yml
REL_COMPOSE_FILE := docker/release/docker-compose.yml

.PHONY: test build release clean

test:
	docker-compose -f $(DEV_COMPOSE_FILE) build
	docker-compose -f $(DEV_COMPOSE_FILE) up agent
	docker-compose -f $(DEV_COMPOSE_FILE) up test

build:
	docker-compose -f $(DEV_COMPOSE_FILE) up builder

release:
	docker-compose -f $(REL_COMPOSE_FILE) build
	docker-compose -f $(REL_COMPOSE_FILE) up agent
	docker-compose -f $(REL_COMPOSE_FILE) run --rm app manage.py collectstatic --noinput
	docker-compose -f $(REL_COMPOSE_FILE) run --rm app manage.py migrate --no-input
	docker-compose -f $(REL_COMPOSE_FILE) up test

clean:
	docker-compose -f $(DEV_COMPOSE_FILE) kill
	docker-compose -f $(DEV_COMPOSE_FILE) rm -f
	docker-compose -f $(REL_COMPOSE_FILE) kill
	docker-compose -f $(REL_COMPOSE_FILE) rm -f




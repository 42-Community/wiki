#---- Makefile --------------------------------------------------------#

#---- variables -------------------------------------------------------#

ENV_FILE		=	.env/database-env

#---- docker commands -------------------------------------------------#

DOCKER_FILE     = docker-compose.yaml
COMPOSE         = docker compose
COMPOSE_F       = docker compose -f
STOP            = docker compose stop
RM              = docker compose rm
RM_IMG          = docker rmi
VOLUME          = docker volume
NETWORK         = docker network
SYSTEM          = docker system

#---- rules -----------------------------------------------------------#

#---- base ----#

debug:
	$(COMPOSE_F) $(DOCKER_FILE) --env-file $(ENV_FILE) up --build --remove-orphans

all: up

up: 
	$(COMPOSE_F) $(DOCKER_FILE) --env-file $(ENV_FILE) up -d

build: 
	$(COMPOSE_F) $(DOCKER_FILE) --env-file $(ENV_FILE) build

#---- build rules ----#

build_parallel:
	$(COMPOSE) build --parallel

watch:
	$(COMPOSE) watch

#---- stop rules ----#

down:
	$(COMPOSE) down

down_restart:
	$(COMPOSE) down -v

restart:
	$(COMPOSE) restart

kill:
	$(COMPOSE) kill

reset: | fclean
	make debug

#---- clean ----#
# - Stops all running containers
# - Removes all stopped containers
# - Stops Docker Compose services
# - Cleans specific directories and files (migrations, tokens, vault)
clean: | down
	docker stop $$(docker ps -qa) || true
	docker rm $$(docker ps -qa) || true
	$(COMPOSE) stop || true
	rm -rf `find . | grep migrations | grep -v env` || true

# - Completely removes Docker Compose services, including images, volumes, and orphans
# - Removes all Docker images
# - Removes all Docker volumes
# - Removes all Docker networks
# - Cleans the specified volume path
fclean: | clean
	$(COMPOSE) down --rmi all --volumes --remove-orphans || true
	docker rmi $$(docker images -q) || true
	docker volume rm $$(docker volume ls -q) || true
	docker network rm $$(docker network ls -q) 2>/dev/null || true
	./pass.sh

#---- re ----#

re: | down
	make all

#---- settings --------------------------------------------------------#

.SILENT:
.DEFAULT: all
.PHONY: all up build down build_parallel down_restart restart kill \
		reset copyfile modsec tutum test clean fclean prune db_suppr \
		db_reset re

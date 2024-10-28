#!/usr/bin/env bash

if [ ! -d "./.env" ]; then
	echo "Generation env files";
	./tools/env-generator.sh;
fi

docker compose --env-file .env/database-env down;
docker volume rm `docker volume ls | grep wiki`
docker compose --env-file .env/database-env up --build;

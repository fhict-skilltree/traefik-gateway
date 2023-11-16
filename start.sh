docker network inspect traefik-gateway >/dev/null 2>&1 || \
    docker network create traefik-gateway

docker-compose up -d
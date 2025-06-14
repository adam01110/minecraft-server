# datbase
up-database:
  docker compose -f ./compose/database.yml up -d
down-database:
  docker compose -f ./compose/database.yml down
logs-database:
  docker compose -f ./compose/database.yml logs

# proxy
up-proxy:
  docker compose -f ./compose/proxy.yml up -d
down-proxy:
  docker compose -f ./compose/proxy.yml down
logs-proxy:
  docker compose -f ./compose/proxy.yml logs

# minecraft
up-minecraft:
  docker compose -f ./compose/minecraft.yml up -d
down-minecraft:
  docker compose -f ./compose/minecraft.yml down
logs-minecraft:
  docker compose -f ./compose/minecraft.yml logs

# broadcaster
up-broadcaster:
  docker compose -f ./compose/broadcaster.yml up -d
down-broadcaster:
  docker compose -f ./compose/broadcaster.yml down
logs-broadcaster:
  docker compose -f ./compose/broadcaster.yml logs

# attach
attach-mariadb:
  docker exec -it mariadb mysql -u root -p
attach-minecraft:
  docker compose -f ./compose/minecraft.yml attach minecraft
attach-velocity:
  docker compose -f ./compose/proxy.yml attach velocity

# setup
setup:
  docker network create velocity-minecraft
  docker network create broadcaster-velocity
  docker network create mariadb
  docker network create valkey
  scripts/download-leaf.sh
  openssl rand -base64 9 | tr -dc 'a-zA-Z0-9' | head -c12 | tee secrets/forwarding.secret | sed 's/^/PAPER_VELOCITY_SECRET: /' > secrets/forwarding-secret.env

# update
update:
  scripts/download-leaf.sh
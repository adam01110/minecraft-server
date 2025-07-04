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
attach-database:
  docker exec -it mariadb /usr/bin/mariadb -u root -p
attach-minecraft:
  docker compose -f ./compose/minecraft.yml attach minecraft
attach-proxy:
  docker compose -f ./compose/proxy.yml attach velocity

# setup
setup:
  docker network create velocity-minecraft
  docker network create broadcaster-velocity
  docker network create mariadb
  scripts/download-leaf.sh
  openssl rand -base64 9 | tr -dc 'a-zA-Z0-9' | head -c12 | tee secrets/forwarding.secret | sed 's/^/PAPER_VELOCITY_SECRET: /' > secrets/forwarding-secret.env
  head /dev/urandom | tr -dc '1-9' | head -c 19 > secrets/seed-obfuscation-key.txt

# update
update:
  scripts/download-leaf.sh
  docker compose -f ./compose/broadcaster.yml pull
  docker compose -f ./compose/database.yml pull
  docker compose -f ./compose/minecraft.yml pull
  docker compose -f ./compose/proxy.yml pull

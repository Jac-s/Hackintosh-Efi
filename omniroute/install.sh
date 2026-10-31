#!/usr/bin/env bash
# Installe et lance OmniRoute avec Docker, avec des secrets générés aléatoirement.
set -euo pipefail
cd "$(dirname "$0")"

command -v docker >/dev/null || { echo "Docker est requis : https://docs.docker.com/get-docker/"; exit 1; }

if [ ! -f .env ]; then
  password=$(openssl rand -base64 18 | tr -d '/+=')
  cat > .env <<ENV
INITIAL_PASSWORD=${password}
JWT_SECRET=$(openssl rand -hex 32)
API_KEY_SECRET=$(openssl rand -hex 32)
STORAGE_ENCRYPTION_KEY=$(openssl rand -hex 32)
REQUIRE_API_KEY=true
ENV
  chmod 600 .env
  echo "Mot de passe du tableau de bord : ${password}  (aussi dans .env)"
fi

docker compose up -d
echo "OmniRoute : http://localhost:20128"

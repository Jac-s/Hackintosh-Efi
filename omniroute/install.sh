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

docker compose --profile tunnel up -d
echo "Interface locale : http://localhost:20128"
echo "Adresse publique (patiente quelques secondes) :"
for _ in $(seq 1 30); do
  url=$(docker compose logs tunnel 2>/dev/null | grep -o 'https://[a-z0-9-]*\.trycloudflare\.com' | tail -1 || true)
  [ -n "$url" ] && { echo "$url   <- ouvre-la pour l'interface, API sur $url/v1"; exit 0; }
  sleep 2
done
echo "Adresse introuvable, vois : docker compose logs tunnel"

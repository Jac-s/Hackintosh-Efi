# OmniRoute

Routeur d'IA : une seule adresse (`http://localhost:20128/v1`, format OpenAI) pour tous tes
fournisseurs, avec bascule automatique quand l'un tombe ou atteint sa limite.
Projet : https://github.com/diegosouzapw/OmniRoute

## Installation (sur une machine qui reste allumée : PC, Mac, serveur, VPS)

Prérequis : Docker.

```bash
git clone https://github.com/Jac-s/Hackintosh-Efi.git
cd Hackintosh-Efi/omniroute
./install.sh
```

Le script génère les secrets et un mot de passe, puis lance le tout. Ouvre ensuite
http://localhost:20128, connecte tes fournisseurs et crée une clé API dans le tableau de bord.

Mise à jour : `docker compose pull && docker compose up -d`.

## L'utiliser depuis partout

Le port est volontairement limité à la machine locale. Pour y accéder à distance, choisis une option :

- **Tailscale (le plus simple et le plus sûr)** : installe Tailscale sur la machine et sur tes
  appareils, puis `tailscale serve --bg 20128`. Adresse : `https://<machine>.<tailnet>.ts.net`.
- **Cloudflare Tunnel** : `cloudflared tunnel --url http://localhost:20128` (adresse publique,
  garde `REQUIRE_API_KEY=true` et un mot de passe fort).

## Dans tes outils

- URL de base : `<adresse>/v1`
- Clé API : celle créée dans le tableau de bord d'OmniRoute

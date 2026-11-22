#!/usr/bin/env bash
set -euo pipefail

RUNTIME_USER="${RUNTIME_USER:-$USER}"
QUADLET_DIR="$HOME/.config/containers/systemd"
SERVICE_HOME="$HOME/mayo-server"


mkdir -p \
    "$QUADLET_DIR" \
    "$SERVICE_HOME/data/traefik" \
    "$SERVICE_HOME/runtime/traefik/letsencrypt" \

if [[ ! -f "$SERVICE_HOME/runtime/traefik/letsencrypt/acme.json" ]]; then
    touch "$SERVICE_HOME/runtime/traefik/letsencrypt/acme.json"
    chmod 600 "$SERVICE_HOME/runtime/traefik/letsencrypt/acme.json"
fi

ln -sf "$SERVICE_HOME/traefik.network" "$QUADLET_DIR/traefik.network"
ln -sf "$SERVICE_HOME/traefik.container" "$QUADLET_DIR/traefik.container"

systemctl --user daemon-reload

systemctl --user restart traefik.service

for service in $SERVICE_HOME/subserv/*; do
    $SERVICE_HOME/$service/tools/services.sh
done

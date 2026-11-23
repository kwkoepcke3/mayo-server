#!/usr/bin/env bash
set -euo pipefail

SERVICE_HOME="$HOME/mayo-server"

ENV_FILE="$SERVICE_HOME/traefik.env"
TMPL_FILE="$SERVICE_HOME/data/traefik/dynamic.yml.tmpl"
OUT_FILE="$SERVICE_HOME/runtime/traefik/dynamic.yml"

# Read raw value without sourcing so $2y$05$ is never expanded by the shell
raw_auth="$(grep '^TRAEFIK_BASICAUTH_ADMIN=' "$ENV_FILE" | head -n1 | cut -d= -f2-)"

TRAEFIK_BASICAUTH_ADMIN="$raw_auth" envsubst '$TRAEFIK_BASICAUTH_ADMIN' < "$TMPL_FILE" > "$OUT_FILE"

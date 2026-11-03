# ---- Docker: Pi first, Mac (Colima) fallback ----
export DOCKER_PI_CTX=homelab
export DOCKER_PI_SSH=homelab

docker() {
  if [[ -n "$DOCKER_CONTEXT" ]]; then
    command docker "$@"; return
  fi
  local ctx
  if ssh -O check "$DOCKER_PI_SSH" 2>/dev/null || \
     ssh -o BatchMode=yes "$DOCKER_PI_SSH" true 2>/dev/null; then
    ctx=$DOCKER_PI_CTX
  else
    ctx=colima
    if ! colima status >/dev/null 2>&1; then
      echo "⚠️  Pi unreachable — starting Colima on the Mac..." >&2
      colima start >/dev/null 2>&1 || { echo "Colima failed to start" >&2; return 1; }
    fi
    echo "→ running on Mac (colima)" >&2
  fi
  command docker --context "$ctx" "$@"
}

alias dwhere='docker info --format "{{.Name}}"'
alias dmac='DOCKER_CONTEXT=colima command docker'
alias dmacoff='colima stop'

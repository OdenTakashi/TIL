#!/bin/sh
set -eu

if [ "${STRIP_IP:-}" = "1" ]; then
  for iface in /sys/class/net/*; do
    name=$(basename "$iface")
    [ "$name" = lo ] && continue
    ip -4 addr flush dev "$name" 2>/dev/null || true
    ip -6 addr flush dev "$name" 2>/dev/null || true
  done
fi

exec "$@"

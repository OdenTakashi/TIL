#!/bin/sh
set -eu

iface_of() {
  want=$(printf '%s' "$1" | tr 'A-F' 'a-f')
  for path in /sys/class/net/*/address; do
    got=$(tr 'A-F' 'a-f' < "$path" | tr -d '\n')
    if [ "$got" = "$want" ]; then
      basename "$(dirname "$path")"
      return 0
    fi
  done
  return 0
}

west=$(iface_of 02:00:00:00:00:0b || true)
east=$(iface_of 02:00:00:00:00:b1 || true)

if [ -n "${west:-}" ]; then
  ip link set "$west" nomaster 2>/dev/null || true
fi
if [ -n "${east:-}" ]; then
  ip link set "$east" nomaster 2>/dev/null || true
fi
ip link del br0 2>/dev/null || true

echo "host-b is a host"
ip -br link

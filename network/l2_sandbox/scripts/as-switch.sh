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
  echo "no iface for $1" >&2
  return 1
}

west=$(iface_of 02:00:00:00:00:0b)
east=$(iface_of 02:00:00:00:00:b1)

if [ ! -d /sys/class/net/br0 ]; then
  ip link add br0 type bridge
fi

ip link set br0 type bridge stp_state 0
ip link set "$west" nomaster 2>/dev/null || true
ip link set "$east" nomaster 2>/dev/null || true
ip link set "$west" master br0
ip link set "$east" master br0
ip link set "$west" up
ip link set "$east" up
ip link set br0 up
ip -4 addr flush dev br0 2>/dev/null || true
ip -6 addr flush dev br0 2>/dev/null || true

if [ -e /proc/sys/net/bridge/bridge-nf-call-iptables ]; then
  echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
fi
if [ -e /proc/sys/net/bridge/bridge-nf-call-ip6tables ]; then
  echo 0 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
fi

if command -v iptables >/dev/null; then
  iptables -P FORWARD ACCEPT 2>/dev/null || true
  iptables -C FORWARD -j ACCEPT 2>/dev/null || iptables -I FORWARD -j ACCEPT
fi

echo "host-b is a switch (br0: $west + $east)"
ip -br link

#!/bin/bash

COLOUR_BAD="cc9090"

IFACE=$(ifconfig | grep tun | awk '{print $1}')

if [[ "$(pgrep -x openvpn)" && ! -z "$IFACE" ]]; then
  echo ""
else
  echo "%{F#${COLOUR_BAD}}%{u#${COLOUR_BAD}}輦 VPN not active!%{u-}%{F-}"
fi

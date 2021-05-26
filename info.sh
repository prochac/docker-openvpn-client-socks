#!/bin/sh

ip_addr=$(docker inspect openvpn-client-socks | jq -r '.[0].NetworkSettings.IPAddress' )

echo "Sock server:"
echo "socks5h://${ip_addr}:1080"

#!/bin/bash
#set -xe
#USER_AGENT="WireGuard-AndroidROMBuild/0.1 ($(uname -a))"

#[[ $(( $(date +%s) - $(stat -c %Y "net/wireguard/.check" 2>/dev/null || echo 0) )) -gt 86400 ]] || exit 0

#[[ $(curl -A "$USER_AGENT" -LSs https://git.zx2c4.com/WireGuard/refs/) =~ snapshot/WireGuard-([0-9.]+)\.tar\.xz ]]

#if [[ -f net/wireguard/version.h && $(< net/wireguard/version.h) == *${BASH_REMATCH[1]}* ]]; then
#	touch net/wireguard/.check
#	exit 0
#fi

#rm -rf net/wireguard
#mkdir -p net/wireguard
#curl -A "$USER_AGENT" -LsS "https://git.zx2c4.com/WireGuard/snapshot/WireGuard-${BASH_REMATCH[1]}.tar.xz" | tar -C "net/wireguard" -xJf - --strip-components=2 "WireGuard-${BASH_REMATCH[1]}/src"
#sed -i 's/tristate/bool/;s/default m/default y/;' net/wireguard/Kconfig
#touch net/wireguard/.check


# CHATGPT

USER_AGENT="WireGuard-AndroidROMBuild/0.1 ($(uname -a))"

# Define the WireGuard version and URL
WG_VERSION="0.0.20191219"
WG_URL="https://git.zx2c4.com/wireguard-monolithic-historical/snapshot/wireguard-monolithic-historical-${WG_VERSION}.tar.xz"

# Check if it's been more than 24 hours since the last update
[[ $(( $(date +%s) - $(stat -c %Y "net/wireguard/.check" 2>/dev/null || echo 0) )) -gt 86400 ]] || exit 0

# Skip download if the current version matches
if [[ -f net/wireguard/version.h && $(< net/wireguard/version.h) == *"$WG_VERSION"* ]]; then
    touch net/wireguard/.check
    exit 0
fi

# Update WireGuard source
rm -rf net/wireguard
mkdir -p net/wireguard
curl -A "$USER_AGENT" -LsS "$WG_URL" | tar -C "net/wireguard" -xJf - --strip-components=2 "wireguard-monolithic-historical-${WG_VERSION}/src"
sed -i 's/tristate/bool/;s/default m/default y/;' net/wireguard/Kconfig
touch net/wireguard/.check

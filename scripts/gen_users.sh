#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 client-name"
    exit 1;
fi

if [ "$(pwd)" != '/etc/openvpn' ]; then
    echo "You should be in /etc/openvpn/"
    exit 1
fi

client="$1"

./build-key --batch

# TODO tar.xz keys and certs

#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 client-name"
    exit 1;
fi

client="$1"
owner="${2-$client}"

if [ "$(pwd)" != "/etc/openvpn/easy-rsa" ]; then
    echo "You should be in /etc/openvpn/easy-rsa/"
    echo "Debian Wheezy: 'cp -R /usr/share/doc/openvpn/examples/easy-rsa/2.0/* /etc/openvpn/easy-rsa/'"
    echo "Debian Jessie: 'apt-get install easy-rsa && cp -R /usr/share/easy-rsa/* /etc/openvpn/easy-rsa/'"
    exit 1
fi

if [ ! -d "keys" ]; then
    mkdir keys
fi

if [ -f "keys/$client" ]; then
    echo "Client $client already has a certificate"
fi

. vars > /dev/null

export KEY_EMAIL="$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1)@sm.net"

./build-key --batch "$client"

if [ -f 'foobar.conf' ]; then
    cp 'foobar.conf' "${client}.conf"
    sed -i s/foorbar/"$client"/g "${client}.conf"
fi

(tar cfJ "$client".tar.xz keys/ca.crt "keys/$client".{key,crt} "${client}.conf")

rm "${client}.conf"

if ! id "$owner"; then
    useradd -m "$owner"
fi

mv "$client".tar.xz /home/"$owner"/

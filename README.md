# sm.net
OpenVPN configurations for sm.net

### Come join us !

* Acquire keys.

* Move content of provided tar.xz to /etc/openvpn

* Add vpn domain

`sudo su -c 'echo "192.95.24.69 sm.net" >> /etc/hosts'`

* Reload openvpn configuration

`systemctl restart openvpn@clientname`

# sm.net
OpenVPN configurations for sm.net

### Come join us !

* Acquire keys

* Move content of provided tar.xz to /etc/openvpn
* 
* Make sure your openvpn config reflects files on your disk

* Add vpn domain

`sudo su -c 'echo "192.95.24.69 sm.net" >> /etc/hosts'`

* Reload openvpn configuration

`systemctl restart openvpn@clientname`

### Recommended additionnal setup

To avoid having 10.2.0.1 as your main DNS, it is recommended to use Unbound.

The example below will forward all DNS requests to `8.8.8.8` except for `sm`. All domains ending with `sm` will use our custom DNS server.

```
server:
  use-syslog: yes
  username: "unbound"
  directory: "/etc/unbound"
  auto-trust-anchor-file: "/var/lib/unbound/root.key"
  do-not-query-localhost: no
  forward-zone:
    name: "."
    forward-addr: 8.8.8.8@53
  forward-zone:
    name: "sm."
    forward-addr: 10.2.0.1@53
```



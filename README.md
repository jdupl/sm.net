# sm.net
OpenVPN configurations for sm.net

### Come join us !

* Acquire keys

* Move content of provided tar.xz to /etc/openvpn

* Check openvpn config key paths and protocol (udp)

* Add vpn domain

`sudo su -c 'echo "192.95.24.69 sm.net" >> /etc/hosts'`

* Reload openvpn configuration

`systemctl restart openvpn@clientname`

### Recommended additionnal setup

#### DNS

To avoid having 10.2.0.1 as your main DNS, it is recommended to use Unbound.

The example below will forward all DNS requests to `8.8.8.8` except for `sm`.
All domains ending with `sm` will use the VPN's DNS server.

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


#### Automatic reconnecting

Removing the lines 
```
user nobody
group nogroup
``` 
is necessary for openvpn to be able to reconnect to the server automatically.


### Support
The configurations are tested on Debian

### Other Linux Distributions
Before starting the openvpn service, make sure you have the linux group nogroup added to your system(e.g. Arch Linux, Fedora, etc...). If your don't want the nogroup added to your system, another option is to simply change the group in your configuration file to match your current system(e.g. nobody instead of nogroup).

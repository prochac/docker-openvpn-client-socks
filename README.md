# OpenVPN-client

This is a docker image of an OpenVPN client tied to a SOCKS proxy server.  It is
useful to isolate network changes (so the host is not affected by the modified
routing).

## Usage

Preferably, using `start` in this repository:
```bash
start client_config.ovpn
```

Alternatively, using `docker run` directly:

```bash
docker run -t -i --device=/dev/net/tun --cap-add=NET_ADMIN \
    --publish 127.0.0.1:1080:1080 \
    --volume client_config.ovpn:/ovpn.conf:ro \
    mook/openvpn-client-socks
```

### OpenVPN Configuration Constraints

- The configuration file must have embedded certificates; references to other
  files are not allowed.
- The configuration file must use `dev tun0`.

### Credentials

This fork has hardcoded copy of `credentials.conf` file into the Docker image.
If you want to use this file, make sure your `*.ovpn` config file contains following config line.
```text
auth-user-pass credentials.conf
```

The file should content user and password per separate line.
```text
username
password
```

### Connection with Firefox

You can use helper script to get the address of SOCKS if the container is running.
```sh
$ ./info.sh
Sock server:
socks5h://172.17.0.2:1080
```

In `Preferences` choose `General` tab and scroll down to `Network Settings` and click on `Settings...` button.
Or use search bar and search for "proxy".

In `Connection Settings` modal select `Manual proxy configuration` and in `SOCKS Host` insert IP address from info script, port to `Port` field and make sure that `SOCKS v5` is selected.
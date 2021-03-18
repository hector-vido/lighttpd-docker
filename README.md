# Lighttpd

This repository was creiated to keep every necessary files to build a container with [lighttpd](https://www.lighttpd.net/) loggin to `/dev/stderr`.

To build:

```bash
git clone https://github.com/hector-vido/lighttpd-docker
cd lighttpd-docker
docker build -t lighttpd .
```

To run:

```bash
docker run -d --name lighttpd -p 8080:80 lighttpd
curl localhost:8080
```

You can watch logs normally on container:

```bash
docker logs -f lighttpd
```

## How It Works

The container entrypoint change the permission of `/dev/stderr` before the main process start:

```bash
#!/bin/sh

# Allow lighttpd to log access on /dev/stderr

chown lighttpd: /dev/stderr
exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
```

And then, inside configuration file, we removed `server.errorlog` to allow it log to `STDERR` and configured `accesslog.filename`:

```js
server.modules += ("mod_accesslog")
accesslog.filename = "/dev/stderr"
```

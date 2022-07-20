# Dockerized Munin node

A docker-based munin node that can be spinned specificying what plugins to load

## Quickstart

1. Add the following to your _existing_ `docker-compose.yml`

```
services:
  munin-node:
    image: darioguarascio/munin-node:latest
    privileged: true
    restart: "always"
    environment:
      MUNIN_ALLOW: ${MUNIN_ALLOW:-0.0.0.0/0}
      MUNIN_ENABLED_PLUGINS: ${MUNIN_ENABLED_PLUGINS:-traffic cpu df netstat system* load memory uptime}
      MUNIN_LINKED_PLUGINS: ${MUNIN_LINKED_PLUGINS:-}
    volumes:
      - /tmp/munin-node:/data
    ports:
      - ${MUNIN_LISTEN:-127.0.0.1:4949}:4949
    env_file:
      - ${MUNIN_ENV_FILE:-.env}
```

2. Add following variables to your `.env` file

```
MUNIN_ALLOW=0.0.0.0/0
MUNIN_LISTEN=0.0.0.0:4949
MUNIN_ENABLED_PLUGINS=cpu df netstat system* load memory uptime

```

3. Run `docker-compose up -d`




## ENV variables


### MUNIN_ALLOW

Variable to define what ip address / netmask can be used to access munin

### MUNIN_LISTEN

`ip:port` to have munin listening to

### MUNIN_ENABLED_PLUGINS

Space separated list of plugins
IE:
```
cpu disk memory load
```

### MUNIN_LINKED_PLUGINS

Space separated list of plugins in the form of `<filename:linked_filename>`.
IE:

```
postgres_locks_:postgres_locks_ALL

```

#### Varnish linked plugin
To load varnish, there is a workaround.
Adding a cronjob to fetch stats on *host* machine that generates a files that is mounted into the munin-node container:
```
* * * * * cd /root/ && /usr/local/bin/docker-compose exec -T varnish varnishstat -x > /tmp/munin-node/varnishstat2 && mv /tmp/munin-node/varnishstat2 /tmp/munin-node/varnishstat
```


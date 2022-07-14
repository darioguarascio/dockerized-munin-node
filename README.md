# Dockerized Munin node

A docker-based munin node that can be spinned specificying what plugins to load

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




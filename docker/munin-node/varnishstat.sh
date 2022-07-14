#!/bin/sh

# Workaround to have a munin-node inside docker read necessary data for varnish plugin to work:
# mounting a shared file, and host machine refreshing this file in cron:
# * * * * * docker-compose exec varnish varnishstat -x > /tmp/munin-node/varnishstat

cat /data/varnishstat

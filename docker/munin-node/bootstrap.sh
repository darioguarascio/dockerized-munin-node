#!/bin/bash

MUNIN_CONFIGURATION_FILE=/etc/munin/munin-node.conf
MUNIN_LOG_FILE=/var/log/munin/munin-node-configure.log

if [ ! -z "$MUNIN_ALLOW" ]; then
	echo $MUNIN_ALLOW | tr -s ',' '\n' | while read ip; do
	    echo "cidr_allow $ip" >> $MUNIN_CONFIGURATION_FILE
	done
fi

# if /var/lib/muninplugins/ do exist, soft link to /etc/munin/plugins
rm -vf /etc/munin/plugins/*


for plugin in $MUNIN_ENABLED_PLUGINS; do
	for i in `ls /usr/share/munin/plugins/$plugin`; do
		ln -s /usr/share/munin/plugins/$(basename $i) /etc/munin/plugins/$(basename $i)
	done
done

for plugin in $MUNIN_LINKED_PLUGINS; do
	F=`echo $plugin | cut -f1 -d:`
	D=`echo $plugin | cut -f2 -d:`
	for i in `ls /usr/share/munin/plugins/$F`; do
		ln -s /usr/share/munin/plugins/$(basename $i) /etc/munin/plugins/$D
	done
done


#ls -lah /etc/munin/plugins/

/etc/init.d/munin-node start
tailf $MUNIN_LOG_FILE
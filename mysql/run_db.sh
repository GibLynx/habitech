#!/bin/bash

[ "$(ls -A /var/lib/mysql)" ] || tar xpzvf /tmp/default_mysql.tar.gz

/entrypoint.sh mysqld

#!/bin/bash

# Initialize MySQL.
/entrypoint.sh mysqld & sleep 50

# Run sql file as soon as MySQL is ready.
mysql -u root -pb0ss < /tmp/habitech.sql

# Create a tar file with the database as it currently exists.
tar czvf /tar/default_mysql.tar.gz /var/lib/mysql

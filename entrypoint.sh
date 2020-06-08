#!/bin/sh
set -eu

rsync -rlDog --chown www-data:root --delete --exclude=/data /usr/src/rainloop/ /var/www/html/
mkdir -p /var/www/html/data
chown www-data.www-data /var/www/html/data

# install missing .htaccess
if [ ! -f /var/www/html/rainloop/v/${RAINLOOP_VERSION}/app/.htaccess ]; then
    {
        echo "Deny from all"
        echo "Options -Indexes"
    } > /var/www/html/rainloop/v/${RAINLOOP_VERSION}/app/.htaccess
    chown www-data.www-data /var/www/html/rainloop/v/${RAINLOOP_VERSION}/app/.htaccess
fi

if [ ! -f /var/www/html/data/.htaccess ]; then
    cp -a /var/www/html/rainloop/v/${RAINLOOP_VERSION}/app/.htaccess /var/www/html/data/.htaccess
fi

exec "$@"

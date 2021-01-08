`!/usr/bin/with-contenv bashio
==============================================================================
Home Assistant Community Add-on: EmonCms
Configures EmonCms
==============================================================================

SQL_SERVER=$(bashio::config "sql.server")
SQL_NAME=$(bashio::config "sql.name")
SQL_USERNAME=$(bashio::config "sql.username")
SQL_PASSWORD=$(bashio::config "sql.password")
SQL_PORT=$(bashio::config "sql.port")

cd /var/www/emoncms

cp example.settings.php settings.php

sed -i "s/\"server\"   => \"localhost\"/\"server\"   => \"${SQL_SERVER}\"/g" settings.php
sed -i "s/\"database\" => \"emoncms\"/\"database\" => \"${SQL_NAME}\"/g" settings.php
sed -i "s/_DB_USER_/${SQL_USERNAME}/g" settings.php
sed -i "s/_DB_PASSWORD_/${SQL_PASSWORD}/g" settings.php
sed -i "s/\"port\"     => 3306/\"port\"     => ${SQL_PORT}/g" settings.php


# Ensure persistant storage exists
# if ! bashio::fs.directory_exists "/data/emoncms"; then
#     bashio::log.debug 'Data directory not initialized, doing that now...'

#     # Setup structure
#     cp -R /var/www/emoncms/emoncms/data /data/emoncms

#     # Ensure file permissions
#     chown -R nginx:nginx /data/emoncms
#     find /data/emoncms -not -perm 0644 -type f -exec chmod 0644 {} \;
#     find /data/emoncms -not -perm 0755 -type d -exec chmod 0755 {} \;
# fi

# bashio::log.debug 'Symlinking data directory to persistent storage location...'
# rm -f -r /var/www/emoncms/tasmoadmin/data
# ln -s /data/emoncms /var/www/emoncms/emoncms/data
`
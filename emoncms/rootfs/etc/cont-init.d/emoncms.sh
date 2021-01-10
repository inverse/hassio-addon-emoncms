#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: EmonCms
# Configures EmonCms
# ==============================================================================

declare sql_server
declare sql_name
declare sql_username
declare sql_pasword
declare sql_port

if bashio::config.has_value 'remote_mysql_host'; then
    sql_server=$(bashio::config "sql.server")
    sql_name=$(bashio::config "sql.name")
    sql_username=$(bashio::config "sql.username")
    sql_pasword=$(bashio::config "sql.password")
    sql_port=$(bashio::config "sql.port")
    # TODO: Validation
else
    if ! bashio::services.available 'mysql'; then
        bashio::log.fatal \
        "Local database access should be provided by the MariaDB addon"
        bashio::exit.nok \
        "Please ensure it is installed and started"
    fi

    sql_server=$(bashio::services "mysql" "host")
    sql_pasword=$(bashio::services "mysql" "password")
    sql_port=$(bashio::services "mysql" "port")
    sql_username=$(bashio::services "mysql" "username")
    sql_name=emoncms

    bashio::log.info "Creating database for Emoncms if required"

    mysql \
        -u "${sql_username}" -p"${sql_pasword}" \
        -h "${sql_server}" -P "${sql_port}" \
        -e "CREATE DATABASE IF NOT EXISTS \`${sql_name}\` ;"
fi


cd /var/www/emoncms

cp example.settings.php settings.php

sed -i "s/\"server\"   => \"localhost\"/\"server\"   => \"${sql_server}\"/g" settings.php
sed -i "s/\"database\" => \"emoncms\"/\"database\" => \"${sql_name}\"/g" settings.php
sed -i "s/_DB_USER_/${sql_username}/g" settings.php
sed -i "s/_DB_PASSWORD_/${sql_pasword}/g" settings.php
sed -i "s/\"port\"     => 3306/\"port\"     => ${sql_port}/g" settings.php


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

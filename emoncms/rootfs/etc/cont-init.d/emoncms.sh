#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: EmonCms
# Configures EmonCms
# ==============================================================================

declare mysql_host
declare mysql_database
declare mysql_username
declare mysql_password
declare mysql_port

if bashio::config.has_value "remote_mysql_host"; then
    if ! bashio::config.has_value 'remote_mysql_database'; then
    bashio::exit.nok \
        "Remote database has been specified but no database is configured"
    fi
sql_poremote_mysql_portremote_mysql_portrt
    if ! bashio::config.has_value 'remote_mysql_username'; then
    bashio::exit.nok \
        "Remote database has been specified but no username is configured"
    fi

    if ! bashio::config.has_value 'remote_mysql_password'; then
    bashio::log.fatal \
        "Remote database has been specified but no password is configured"
    fi

    if ! bashio::config.exists 'remote_mysql_port'; then
    bashio::exit.nok \
        "Remote database has been specified but no port is configured"
    fi
else
    if ! bashio::services.available 'mysql'; then
        bashio::log.fatal \
        "Local database access should be provided by the MariaDB addon"
        bashio::exit.nok \
        "Please ensure it is installed and started"
    fi

    mysql_host=$(bashio::services "mysql" "host")
    mysql_password=$(bashio::services "mysql" "password")
    mysql_port=$(bashio::services "mysql" "port")
    mysql_username=$(bashio::services "mysql" "username")
    mysql_database=emoncms

    bashio::log.warning "Emoncms is using the Maria DB addon"
    bashio::log.warning "Please ensure this is included in your backups"
    bashio::log.warning "Uninstalling the MariaDB addon will remove any data"


    bashio::log.info "Creating database for Emoncms if required"

    mysql \
        -u "${mysql_username}" -p"${mysql_password}" \
        -h "${mysql_host}" -P "${mysql_port}" \
        -e "CREATE DATABASE IF NOT EXISTS \`${mysql_database}\` ;"
fi


cd /var/www/emoncms


bashio::log.info "Configuring settings.php"

cp example.settings.php settings.php

sed -i "s/\"server\"   => \"localhost\"/\"server\"   => \$_ENV['MYSQL_HOST']/g" settings.php
sed -i "s/\"database\" => \"emoncms\"/\"database\" => \$_ENV['MYSQL_NAME']/g" settings.php
sed -i "s/\"_DB_USER_\"/\$_ENV['MYSQL_USERNAME']/g" settings.php
sed -i "s/\"_DB_PASSWORD_\"/\$_ENV['MYSQL_PASSWORD']/g" settings.php
sed -i "s/\"port\"     => 3306/\"port\"     => \$_ENV['MYSQL_PORT']/g" settings.php

# Configure logging

bashio::log.info "Setting up logging"

mkdir -p /var/log/emoncms
ln -sf /dev/stderr /var/log/emoncms/emoncms.log

# TODO: Configure persistant storage

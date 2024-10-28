#!/usr/bin/env bash


echo "Starting installation"

# Reference: https://www.mediawiki.org/wiki/Manual:Install.php
# TODO: Use $DATABASE_NAME
php maintenance/run.php install "42 Community" "$ADMIN_USERNAME" \
    --pass="$ADMIN_PASSWORD" \
    --server="$SERVER_URL" \
    --dbserver="$DATABASE_URL" \
    --dbuser="$DATABASE_USER" \
    --dbpass="$DATABASE_PASSWORD" \
    --with-extensions


# TODO: Find correspoding install script option
sed "s|\$wgScriptPath = '/html';|\$wgScriptPath = '';|" -i LocalSettings.php

echo "require_once 'ExtraLocalSettings.php';" >> LocalSettings.php

# Replace process with apache2
exec apache2-foreground

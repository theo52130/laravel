#!/bin/bash

# Attendre que la base de données soit prête
echo "Waiting for MySQL..."
# Utiliser directement les valeurs sans variables d'environnement
while ! mysqladmin ping -h"db" -u"laraveluser" -p"laravelmdp" --silent; do
    sleep 1
    echo "Retrying connection to MySQL..."
done

echo "MySQL connection successful!"

cd /var/www

# Donner les droits appropriés aux dossiers critiques
chmod -R 775 /var/www/storage
chmod -R 775 /var/www/bootstrap/cache
chown -R www-data:www-data /var/www/storage
chown -R www-data:www-data /var/www/bootstrap/cache

# Exécuter les migrations
php artisan migrate --force

# Démarrer PHP-FPM
php-fpm
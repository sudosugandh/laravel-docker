#!/bin/bash

# Navigate to your Laravel project directory
cd /var/www/html/laravel-docker

# Activate a virtual environment, if applicable

# Pull the latest code from your Git repository
git pull origin main

# Install or update Composer dependencies
composer install --no-dev --no-interaction --prefer-dist

# Run database migrations and other deployment tasks
php artisan migrate --force
# Any other necessary deployment tasks

# Set permissions for Laravel storage and cache directories
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

# Clear Laravel cache
php artisan cache:clear
php artisan config:cache

# Restart Apache
sudo systemctl restart apache2

# If everything is successful, set the deployment success flag
if [ $? -eq 0 ]; then
  echo "Deployment successful"
  exit 0
else
  echo "Deployment failed"
  exit 1
fi

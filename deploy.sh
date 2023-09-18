#!/bin/bash

# Navigate to your Laravel project directory
cd /var/www/html/test-action

# Activate a virtual environment, if applicable

# Pull the latest code from your Git repository
git pull origin main

# Install or update Composer dependencies
composer install --no-dev --no-interaction --prefer-dist

# Run database migrations and other deployment tasks
php artisan migrate --force
# Any other necessary deployment tasks

# Restart your web server, e.g., if you're using Nginx or Apache
# systemctl restart nginx

# If everything is successful, set the deployment success flag
if [ $? -eq 0 ]; then
  echo "Deployment successful"
  exit 0
else
  echo "Deployment failed"
  exit 1
fi

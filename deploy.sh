#!/bin/bash

# Define your Laravel project directory
LARAVEL_PROJECT_DIR="/var/www/html/laravel-docker"

# Define the Git branch you want to deploy (e.g., 'main')
GIT_BRANCH="main"

# Function to check if a command execution was successful
check_success() {
    if [ $? -eq 0 ]; then
        echo "Command successful"
    else
        echo "Command failed"
        exit 1
    fi
}

# Navigate to your Laravel project directory
cd "$LARAVEL_PROJECT_DIR"

# Pull the latest code from your Git repository
git pull origin "$GIT_BRANCH"
check_success

# Activate a virtual environment, if applicable
# (Add your virtual environment activation command here if needed)

# Install or update Composer dependencies
composer install --no-dev --no-interaction --prefer-dist
check_success

# Run database migrations and other deployment tasks
php artisan migrate --force
check_success

# Set permissions for Laravel storage and cache directories
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

# Clear Laravel cache
php artisan cache:clear
php artisan config:cache

# Fix permissions for log files
sudo chown -R www-data:www-data storage/logs
sudo chmod -R 775 storage/logs

# Restart Apache (you can adjust this based on your web server)
sudo systemctl restart apache2

# If everything is successful, set the deployment success flag
echo "Deployment successful"
exit 0

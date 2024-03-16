
FROM php:7.4-apache

WORKDIR /var/www/html

COPY . .

# Install required PHP extensions
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Set permissions to allow WordPress to write to files and directories
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]

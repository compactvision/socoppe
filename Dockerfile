# Utiliser une image PHP avec Apache et extensions nécessaires
FROM php:8.2-apache

# Installer des dépendances système
RUN apt-get update && apt-get install -y \
    curl zip unzip git libpq-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier les fichiers de l'application
COPY . /var/www/html

# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

# Configurer Apache
RUN a2enmod rewrite

# Configurer le point d'entrée
CMD ["apache2-foreground"]

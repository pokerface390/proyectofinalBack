# Usa imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    zip unzip curl libpng-dev libonig-dev libxml2-dev libzip-dev git \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Habilita mod_rewrite
RUN a2enmod rewrite

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del proyecto
COPY . .

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala dependencias Laravel
RUN composer install --no-dev --optimize-autoloader

# Genera la key (si no la pones como variable)
# RUN php artisan key:generate

# Ajusta permisos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expone el puerto 80
EXPOSE 80

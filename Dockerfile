# Imagen base oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones requeridas
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Habilita mod_rewrite de Apache (para rutas Laravel)
RUN a2enmod rewrite

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia todos los archivos del proyecto
COPY . .

# Copia Composer desde imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY .env.example .env


# Instala dependencias Laravel
RUN composer install --no-dev --optimize-autoloader

# Corrige permisos de las carpetas necesarias
RUN chown -R www-data:www-data storage bootstrap/cache

# Expone el puerto 80
EXPOSE 80

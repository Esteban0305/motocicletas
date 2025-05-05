# Usa PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias para SQLite
RUN docker-php-ext-install pdo 

# Copia el contenido del proyecto al contenedor
COPY . /var/www/html/

# Habilita el módulo de reescritura de Apache (opcional, útil si usas .htaccess)
RUN a2enmod rewrite

# Da permisos adecuados a la base de datos
RUN chown -R www-data:www-data /var/www/html/database

# Expone el puerto 80 (por defecto en Apache)
EXPOSE 80

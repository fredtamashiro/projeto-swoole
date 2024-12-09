# Base PHP com Apache
FROM php:8.2-apache

# Instalar dependências do sistema e extensões PHP
RUN apt-get update && apt-get install -y \
    libssl-dev \
    pkg-config \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    curl \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && pecl install openswoole \
    && docker-php-ext-enable openswoole \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Habilitar o modo rewrite do Apache
RUN a2enmod rewrite

# Ajustar o diretório de trabalho
WORKDIR /var/www/html

# Configurar as permissões corretas
RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html

# Expor a porta 80
EXPOSE 80

FROM php:7.4-fpm-alpine
RUN apk --no-cache add shadow && usermod -u 1000 www-data
RUN apk add --no-cache openssl bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www
RUN rm -rf /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN composer install && \
#             cp .env.example .env && \
#             php artisan key:generate && \
#             php artisan config:cache

# COPY . /var/www
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

RUN ln -s public html

# RUN usermod -u 1000 www-data
USER www-data

EXPOSE 9000

ENTRYPOINT ["php-fpm"]
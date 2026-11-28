FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install \
    --no-dev \
    --no-interaction \
    --no-progress \
    --no-scripts \
    --prefer-dist \
    --optimize-autoloader \
    --ignore-platform-req=ext-intl

FROM php:8.4-fpm-alpine AS app
WORKDIR /var/www/html

RUN apk add --no-cache \
    postgresql-dev \
    icu-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql intl zip opcache

COPY . .
COPY --from=vendor /app/vendor ./vendor

RUN rm -f bootstrap/cache/*.php \
    && mkdir -p storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache \
    && php artisan package:discover --ansi \
    && if php artisan list --raw | grep -q "filament:assets"; then php artisan filament:assets; fi \
    && chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]

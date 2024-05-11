#!/bin/bash

WP_PATH="/var/www/html"

# Verifica se o WordPress já está baixado
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root --path="$WP_PATH"
fi

# Cria o arquivo wp-config.php, se necessário
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Setting wp-config.php..."
    wp config create --dbname="$WP_DATABASE" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PWD" --dbhost="$WP_HOST" --allow-root --path="$WP_PATH"
fi

# Instala o WordPress, se ainda não estiver instalado
if ! wp core is-installed --allow-root --path="$WP_PATH"; then
    echo "Install WordPress..."
    wp core install --allow-root --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --path="$WP_PATH"

    # Cria um usuário adicional
    wp user create --allow-root $WP_USER $WP_EMAIL --role=author --user_pass="$WP_PASSWORD" --path="$WP_PATH"

    # Desinstala plugins desnecessários
    wp plugin uninstall akismet hello --allow-root --path="$WP_PATH"

    # Atualiza todos os plugins
    wp plugin update --all --allow-root --path="$WP_PATH"

    # Instala e ativa o tema twentytwentythree
    echo "Installing and activating theme 'twentytwentythree'..."
    wp theme install twentytwentythree --activate --allow-root --path="$WP_PATH"
    
    # Tenta instalar e ativar o plugin Redis Cache
    echo "Installing Redis Cache plugin..."
    wp plugin install redis-cache --allow-root --path="$WP_PATH"
    if wp plugin is-installed redis-cache --allow-root --path="$WP_PATH"; then
        echo "Activating Redis Cache plugin..."
        wp plugin activate redis-cache --allow-root --path="$WP_PATH"
        
        # Habilita o cache de objeto do Redis no wp-config.php
        echo "Configuring Redis Cache..."
        wp config set WP_REDIS_HOST 'redis' --type=constant --allow-root --path="$WP_PATH"
        wp config set WP_REDIS_PORT 6379 --type=constant --allow-root --path="$WP_PATH"
        wp config set WP_CACHE true --type=constant --allow-root --path="$WP_PATH"
        
        # Habilita o cache de objetos do Redis (necessário após a instalação do plugin)
        echo "Enabling Redis object cache..."
        wp redis enable --allow-root --path="$WP_PATH"
    else
        echo "Failed to install Redis Cache plugin. Please check for errors."
    fi
fi

# Ajusta a propriedade do diretório e arquivos para o usuário do servidor web
chown -R www-data:www-data $WP_PATH

# Executa o php-fpm
exec php-fpm7.4 -F

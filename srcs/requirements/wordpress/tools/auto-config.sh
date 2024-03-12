#Pour etre sur que la DB MariaDB a eu le temps de se lancer
sleep 10;

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 --path='/var/www/wordpress';
fi

wp core install --allow-root \
     	--path='/var/www/wordpress' \
	--title='$WP_TITLE'\
	--admin_user='$ADMIN_WP_USER' \
	--admin_password='$AMIN_WP_PASSWORD' \
	--admin_email='$ADMIN_WP_EMAIL';

 wp user create --allow-root --path='/var/www/wordpress'  bob bob@example.com --user_pass='$EX_WP_PASSWORD'
# ?
if [ ! -d "/run/php" ] ; then
	mkdir /run/php;
fi

# Lancer php-fpm
/usr/sbin/php-fpm7.4 -F

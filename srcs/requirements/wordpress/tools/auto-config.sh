#Pour etre sur que la DB MariaDB a eu le temps de se lancer
sleep 10;

echo "User is : $(whoami)";

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	cd /var/www/wordpress/
	echo "Ca rentre dans le if de mon script = FileCreation $SQL_DATABASE $SQL_USER
	
$SQL_PASSWORD " && 
	wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 \
	#--path='/var/www/wordpress';
fi

echo "TEST1";

wp core install
	--url=$DOMAIN_NAME \
	--allow-root \
     	#--path='/var/www/wordpress' \
	--title=$WP_TITLE \
	--admin_user=$ADMIN_WP_USER \
	--admin_password=$AMIN_WP_PASSWORD \
	--admin_email=$ADMIN_WP_EMAIL;

echo "TEST2";
wp user create --allow-root --path='/var/www/wordpress'  bob bob@example.com --user_pass=$EX_WP_PASSWORD
# ?
if [ ! -d "/run/php" ] ; then
	echo "Ca rentre dans le if /run/php n'existe pas" && mkdir /run/php;
fi

echo "Test3";
# Lancer php-fpm
/usr/sbin/php-fpm7.4 -F
